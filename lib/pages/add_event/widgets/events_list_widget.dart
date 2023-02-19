import 'package:calendar_of_events/constants/colors.dart';
import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventsListWidget extends GetView<AddEventController> {
  const EventsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.findEvents();
    final eventsList = controller.eventsList;

    return SliverToBoxAdapter(
      child: Container(
          height: Get.size.height,
          decoration: BoxDecoration(
              color: Colors.grey.shade700,
              border: Border.all(width: 1, color: darkBorder1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
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
                    direction: DismissDirection.horizontal,
                    onDismissed: (DismissDirection direction) {
                      switch (direction) {
                        case DismissDirection.startToEnd:
                          controller.updateEvent(eventsList[index]);
                          break;
                        case DismissDirection.endToStart:
                          controller.deleteEvent(index);
                          break;
                        default:
                      }
                    },
                    secondaryBackground: const DismissBackground(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      icon: Icons.delete,
                    ),
                    background: const DismissBackground(
                      color: Colors.blue,
                      alignment: Alignment.centerLeft,
                      icon: Icons.edit,
                    ),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: const Icon(
                          Icons.circle,
                          color: darkBorder1,
                          size: 25,
                        ),
                        textColor: Colors.white,
                        title: Text(eventsList[index].title),
                        subtitle: (eventsList[index].startTime != null)
                            ? Text(
                                "с ${Utils.toTime(eventsList[index].startTime)}  до ${Utils.toTime(eventsList[index].finishTime)}")
                            : null),
                  )),
            ),
          )),
    );
  }
}

class DismissBackground extends StatelessWidget {
  const DismissBackground({
    required this.color,
    required this.alignment,
    required this.icon,
    super.key,
  });

  final Color color;
  final Alignment alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: alignment,
      child: Icon(icon, color: Colors.white),
    );
  }
}
