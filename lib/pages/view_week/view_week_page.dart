import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/pages/view_week/widgets/calendar_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewWeekPage extends StatelessWidget {
  ViewWeekPage({Key? key}) : super(key: key);
  final CalendarWeekController calendarWeekController =
      Get.put(CalendarWeekController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Get.toNamed('/view_month'),
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ))
            ],
          ),
          GetBuilder<CalendarWeekController>(
            builder: (calendarWeekController) => CalendarWeekWidget(),
          ),
        ],
      )),
    );
  }
}
