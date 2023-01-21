import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DayOfWeekWidget extends GetView<CalendarWeekController> {
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
          Get.toNamed('/add_event')!.whenComplete(() => controller.onInit());
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
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: ListTile(
                                            dense: true,
                                            textColor: Colors.white,
                                            title: Text(eventList[index].title),
                                            subtitle: Text(
                                                "${Utils.toTime(eventList[index].startTime)} - ${Utils.toTime(eventList[index].finishTime)}"),
                                          ),
                                        ),
                                        if (eventList[index].startTime !=
                                            null) ...[
                                          const SizedBox(height: 7),
                                          Text(
                                              "${Utils.toTime(eventList[index].startTime!)} - ${Utils.toTime(eventList[index].finishTime!)}"),
                                        ]
                                      ],
                                    ),
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
