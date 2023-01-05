import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/text_resources.dart';
import 'package:calendar_of_events/widgets/calendar_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final CalendarWeekController calendarWeekController =
      Get.put(CalendarWeekController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        title: Text(appBarTitle.keys.first.tr),
      ),
      body: SafeArea(
          child: GetBuilder<CalendarWeekController>(
        builder: (calendarWeekController) => CalendarWeekWidget(),
      )),
    );
  }
}
