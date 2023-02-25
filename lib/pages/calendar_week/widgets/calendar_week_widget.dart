import 'package:calendar_of_events/constants/colors.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/pages/calendar_week/widgets/day_of_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWeekData {
  final DateTime dayAndMonth;
  final List<Event>? eventList;
  CalendarWeekData(this.dayAndMonth, this.eventList);
}

class CalendarWeekWidget extends GetView<CalendarWeekController> {
  const CalendarWeekWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        return Expanded(
          child: PageView.builder(
              controller: PageController(initialPage: 3),
              itemBuilder: (BuildContext context, pageIndex) {
                final List<CalendarWeekData> nameDay =
                    List.generate(7, (index) {
                  List<Event>? eventList;
                  if (controller.eventsFromDB.isNotEmpty) {
                    eventList = controller.eventsFromDB
                        .where((element) =>
                            element.dayMonth ==
                            controller.firstDayOfWeek
                                .add(Duration(days: index + 7 * pageIndex)))
                        .toList();
                  }

                  return CalendarWeekData(
                      controller.firstDayOfWeek
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
      onLoading:
          const Center(child: CircularProgressIndicator(color: darkBorder1)),
    );
  }
}
