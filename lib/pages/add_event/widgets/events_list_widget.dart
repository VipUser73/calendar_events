import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsListWidget extends StatelessWidget {
  EventsListWidget({super.key});

  final CalendarWeekController calendarWeekController = Get.find();
  final AddEventController addEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    addEventController.findEvents();

    return Container(
        height: Get.size.height - 400,
        decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [
                Colors.black38,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Obx(
          () => ListView.builder(
              itemCount: addEventController.eventsList.length,
              itemBuilder: ((context, index) => ListTile(
                    title: Text(addEventController.eventsList[index].title),
                    subtitle: (addEventController.eventsList[index].startTime ==
                            null)
                        ? null
                        : Text(addEventController.eventsList[index].startTime
                            .toString()),
                  ))),
        ));
  }
}
