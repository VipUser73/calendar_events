import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWeekData {
  final DateTime dayAndMonth;
  final List<Event> eventList;
  CalendarWeekData(this.dayAndMonth, this.eventList);
}

class CalendarWeekWidget extends GetView<CalendarWeekController> {
  CalendarWeekWidget({Key? key}) : super(key: key);

  final AddEventController addEventController = Get.put(AddEventController());
  final CalendarWeekController calendarWeekController = Get.find();
  final PageController pageController = PageController(initialPage: 3);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return GetBuilder<CalendarWeekController>(
          builder: (calendarWeekController) => Expanded(
            child: PageView.builder(
                controller: pageController,
                itemBuilder: (BuildContext context, pageIndex) {
                  final List<CalendarWeekData> nameDay =
                      List.generate(7, (index) {
                    List<Event> eventList = [];
                    if (calendarWeekController.eventsFromDB.isNotEmpty) {
                      try {
                        eventList = calendarWeekController.eventsFromDB
                            .where((element) =>
                                element.dayMonth ==
                                calendarWeekController.firstDayOfWeek
                                    .add(Duration(days: index + 7 * pageIndex)))
                            .toList();
                      } catch (e) {}
                    }

                    return CalendarWeekData(
                        calendarWeekController.firstDayOfWeek
                            .add(Duration(days: index + 7 * pageIndex)),
                        eventList);
                  });

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...nameDay
                          .map((e) => DayOfWeekWidget(
                                dayAndMonth: e.dayAndMonth,
                                eventList: e.eventList,
                              ))
                          .toList(),
                    ],
                  );
                }),
          ),
        );
      },
      onLoading: const Center(child: CircularProgressIndicator()),
    );
  }
}

class DayOfWeekWidget extends StatelessWidget {
  final DateTime dayAndMonth;
  final List<Event> eventList;
  const DayOfWeekWidget({
    required this.dayAndMonth,
    required this.eventList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatDayOfWeek = DateFormat.E('ru').format(dayAndMonth).capitalize!;
    final formatDayAndMonth = DateFormat.Md('ru').format(dayAndMonth);
    bool colorDateTimeNow = false;
    if (DateFormat.Md('ru').format(DateTime.now()) == formatDayAndMonth) {
      colorDateTimeNow = true;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.find<AddEventController>().selectedDate.value = dayAndMonth;
          Get.toNamed('/add_event');
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: Row(
              children: [
                Container(
                  height: double.infinity,
                  width: 70,
                  decoration: BoxDecoration(
                      color: colorDateTimeNow ? Colors.black38 : null,
                      border: Border.all(
                          width: 2, color: const Color.fromRGBO(163, 87, 9, 1)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16))),
                  child: Center(
                    child: Text(
                      "$formatDayOfWeek\n$formatDayAndMonth",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: colorDateTimeNow ? Colors.black38 : null,
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(163, 87, 9, 1)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: eventList.isNotEmpty
                        ? ListView.builder(
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: eventList.length,
                            itemBuilder: ((context, index) => Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 12),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.grey),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(eventList[index].title),
                                            if (eventList[index].startTime !=
                                                null) ...[
                                              const SizedBox(height: 7),
                                              Text(
                                                  "${Utils.toTime(eventList[index].startTime!)} - ${Utils.toTime(eventList[index].finishTime!)}"),
                                            ]
                                          ],
                                        )),
                                  ],
                                )))
                        : const SizedBox(),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
