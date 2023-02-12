import 'package:calendar_of_events/pages/calendar_week/widgets/appbar_widget.dart';
import 'package:calendar_of_events/pages/calendar_week/widgets/calendar_week_widget.dart';
import 'package:flutter/material.dart';

class CalendarWeekPage extends StatelessWidget {
  const CalendarWeekPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Column(
          children: const [
            AppBarWidget(),
            CalendarWeekWidget(),
          ],
        ),
      )),
    );
  }
}
