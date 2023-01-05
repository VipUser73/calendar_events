import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
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
          builder: (calendarWeekController) => PageView.builder(
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
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 9),
            decoration: BoxDecoration(
                color: colorDateTimeNow ? Colors.black38 : null,
                border: Border.all(width: 1, color: Colors.green)),
            child: Row(
              children: [
                Text(
                  "$formatDayOfWeek\n$formatDayAndMonth",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const VerticalDivider(
                  color: Colors.green,
                  width: 20,
                  thickness: 1,
                ),
                eventList.isNotEmpty
                    ? Flexible(
                        child: ListView.separated(
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: eventList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: ((context, index) => Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.red),
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
                                              Text(eventList[index]
                                                  .startTime
                                                  .toString()),
                                            ]
                                          ],
                                        )),
                                  ],
                                ))),
                      )
                    : const Text('')
              ],
            )),
      ),
    );
  }
}
