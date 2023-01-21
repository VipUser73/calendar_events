import 'package:calendar_of_events/pages/calendar_week/widgets/calendar_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWeekPage extends StatelessWidget {
  const CalendarWeekPage({Key? key}) : super(key: key);
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
          const CalendarWeekWidget(),
        ],
      )),
    );
  }
}
