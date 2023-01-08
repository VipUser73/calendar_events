import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsListWidget extends StatelessWidget {
  EventsListWidget({super.key});

  final CalendarWeekController calendarWeekController = Get.find();
  final AddEventController addEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    addEventController.findEvents();
    final eventsList = addEventController.eventsList;

    return Container(
        height: Get.size.height,
        decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            gradient: LinearGradient(
              colors: [
                Colors.grey.shade700,
                const Color.fromRGBO(36, 35, 32, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Obx(
          () => ListView.builder(
            physics:
                const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            itemCount: eventsList.length,
            itemBuilder: ((context, index) => Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) =>
                      addEventController.deleteEvent(eventsList[index].title),
                  background: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: SizedBox(
                    width: 200,
                    child: ListTile(
                        tileColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textColor: Colors.white,
                        title: Text(eventsList[index].title),
                        subtitle: (eventsList[index].startTime != null)
                            ? Text(
                                "с ${Utils.toTime(eventsList[index].startTime!)}  до ${Utils.toTime(eventsList[index].finishTime!)}")
                            : null),
                  ),
                )),
          ),
        ));
  }
}
