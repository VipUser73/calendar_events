import 'package:calendar_of_events/get_routes.dart';
import 'package:calendar_of_events/pages/calendar_week/widgets/appbar_widget.dart';
import 'package:calendar_of_events/pages/calendar_week/widgets/calendar_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWeekPage extends StatelessWidget {
  const CalendarWeekPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            AppBarWidget(
              press: () => Get.toNamed(Routes.calendarMonthPage),
            ),
            const CalendarWeekWidget(),
          ],
        ),
      )),
    );
  }
}
