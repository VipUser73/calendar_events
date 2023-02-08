import 'package:calendar_of_events/constants/colors.dart';
import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/pages/add_event/widgets/date_time_widget.dart';
import 'package:calendar_of_events/pages/add_event/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSliverBox extends GetView<AddEventController> {
  const TopSliverBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        controller
                          ..saveForm()
                          ..titleController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            TextFieldWidget(),
            DateTimeWidget(isData: true),
            Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Switch(
                      inactiveThumbColor: darkBorder1,
                      inactiveTrackColor: Colors.grey,
                      value: controller.flag.value,
                      onChanged: (_) => controller.flag.toggle()),
                )),
            Obx(() => Visibility(
                  visible: controller.flag.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DateTimeWidget(isStartTime: true),
                        const SizedBox(width: 10),
                        DateTimeWidget(),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
