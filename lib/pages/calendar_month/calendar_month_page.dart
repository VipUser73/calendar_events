import 'package:calendar_of_events/constants/colors.dart';
import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/get_routes.dart';
import 'package:calendar_of_events/models/event_data_source.dart';
import 'package:calendar_of_events/pages/calendar_week/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarMonthPage extends GetView<CalendarWeekController> {
  const CalendarMonthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              press: Get.back,
            ),
            Expanded(
              child: SfCalendar(
                headerHeight: 30,
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
                cellBorderColor: darkBorder2,
                todayHighlightColor: darkBorder2,
                dataSource: EventDataSource(controller.eventsFromDB),
                initialDisplayDate: DateTime.now(),
                onTap: (details) {
                  Get.find<AddEventController>().selectedDate.value =
                      details.date ?? DateTime.now();
                  Get.toNamed(Routes.addEventPage);
                },
              ),
            ),
            SizedBox(height: Get.height * 0.16)
          ],
        ),
      ),
    );
  }
}
