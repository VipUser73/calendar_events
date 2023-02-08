import 'package:calendar_of_events/get_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () => Get.toNamed(Routes.calendarMonthPage),
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ))
      ],
    );
  }
}
