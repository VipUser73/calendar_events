import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/pages/add_event/widgets/date_time_widget.dart';
import 'package:calendar_of_events/pages/add_event/widgets/events_list_widget.dart';
import 'package:calendar_of_events/pages/add_event/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventPage extends StatelessWidget {
  AddEventPage({Key? key}) : super(key: key);

  final AddEventController addEventController = Get.put(AddEventController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 10, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.close)),
                          IconButton(
                              onPressed: () => addEventController.saveForm(),
                              icon: Icon(Icons.check)),
                        ],
                      ),
                    ),
                    TextFieldWidget(),
                    DateTimeWidget(isData: true),
                    Obx(() => Switch(
                        value: addEventController.flag.value,
                        onChanged: (_) => addEventController.flag.toggle())),
                    Obx(() => Visibility(
                          visible: addEventController.flag.value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DateTimeWidget(isStartTime: true),
                              const SizedBox(width: 10),
                              DateTimeWidget(),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: EventsListWidget(),
            )
          ]),
        ));
  }
}
