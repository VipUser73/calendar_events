import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ViewMonthPage extends StatelessWidget {
  ViewMonthPage({Key? key}) : super(key: key);
  final CalendarWeekController calendarWeekController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: GetBuilder<CalendarWeekController>(
              builder: (calendarWeekController) => SfCalendar(
                //backgroundColor: Colors.white,
                headerHeight: 50,
                view: CalendarView.month,
                firstDayOfWeek: 1,
                selectionDecoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                headerStyle: const CalendarHeaderStyle(
                  textStyle: TextStyle(color: Colors.white),
                ),
                viewHeaderStyle: const ViewHeaderStyle(
                  dayTextStyle: TextStyle(color: Colors.white),
                  dateTextStyle: TextStyle(color: Colors.white),
                ),
                monthViewSettings: MonthViewSettings(
                    monthCellStyle: MonthCellStyle(
                        backgroundColor: Colors.grey.shade800,
                        todayBackgroundColor: Colors.grey.shade700,
                        //trailingDatesBackgroundColor: Colors.grey.shade800,
                        //leadingDatesBackgroundColor: Colors.grey.shade800,

                        textStyle: const TextStyle(color: Colors.white),
                        trailingDatesTextStyle:
                            const TextStyle(color: Colors.white),
                        leadingDatesTextStyle:
                            const TextStyle(color: Colors.white))),
                cellBorderColor: const Color.fromRGBO(163, 87, 9, 1),
                todayHighlightColor: const Color.fromRGBO(163, 87, 9, 1),
                dataSource:
                    EventDataSource(calendarWeekController.eventsFromDB),
                initialDisplayDate: DateTime.now(),
                onLongPress: (details) {
                  Get.find<AddEventController>().selectedDate.value =
                      details.date!;
                  Get.toNamed('/add_event');
                },
              ),
            )),
      ),
    );
  }
}