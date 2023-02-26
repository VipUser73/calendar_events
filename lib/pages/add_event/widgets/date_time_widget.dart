import 'package:calendar_of_events/constants/colors.dart';
import 'package:calendar_of_events/controllers/add_event_controller.dart';
import 'package:calendar_of_events/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeWidget extends StatelessWidget {
  final bool isData;
  final bool isStartTime;
  DateTimeWidget({this.isData = false, this.isStartTime = false, super.key});

  final AddEventController addEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isData ? pickEventDate(context) : pickEventTime(context),
      child: SizedBox(
        width: isData ? 170 : 80,
        height: 60,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: darkBorder1),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Center(
                child: Obx(
              () => Text(
                isData
                    ? Utils.toDate(addEventController.selectedDate.value)
                    : Utils.toTime(isStartTime
                        ? addEventController.selectedStartTime.value
                        : addEventController.selectedFinishTime.value),
                maxLines: 1,
              ),
            ))),
      ),
    );
  }

  Future<void> pickEventDate(BuildContext context) async {
    final data = await showDatePicker(
      context: context,
      initialDate: addEventController.selectedDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2033),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.yellow, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.green, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (data != null && data != addEventController.selectedDate.value) {
      addEventController.selectedDate.value = data;
      addEventController.findEvents();
    }
  }

  Future<void> pickEventTime(BuildContext context) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(addEventController.selectedStartTime.value)
          : TimeOfDay.fromDateTime(addEventController.selectedFinishTime.value),
    );

    if (timeOfDay != null) {
      DateTime currentDateTime = DateTime.now();
      final time = DateTime(currentDateTime.year, currentDateTime.month,
          currentDateTime.day, timeOfDay.hour, timeOfDay.minute);
      if (isStartTime) {
        addEventController.selectedStartTime.value = time;
        if (addEventController.selectedStartTime.value
            .isAfter(addEventController.selectedFinishTime.value)) {
          addEventController.selectedFinishTime.value = time;
        }
      } else {
        addEventController.selectedFinishTime.value = time;
        if (time.isBefore(addEventController.selectedStartTime.value)) {
          addEventController.selectedStartTime.value = time;
        }
      }
    }
  }
}
