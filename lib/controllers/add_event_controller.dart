import 'package:calendar_of_events/controllers/calendar_week_controller.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/services/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEventController extends GetxController {
  final CalendarWeekController calendarWeekController = Get.find();
  final dbProvider = DBProvider();
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  RxList<Event> eventsList = <Event>[].obs;
  final flag = false.obs;

  void findEvents() {
    eventsList.value = calendarWeekController.eventsFromDB
        .where((element) => element.dayMonth == selectedDate.value)
        .toList();
  }

  static DateTime currentDateTime = DateTime.now();

  Rx<DateTime> selectedDate = DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day,
  ).obs;

  Rx<DateTime> selectedStartTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute)
      .obs;
  Rx<DateTime> selectedFinishTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute)
      .obs;
  Future<void> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      final event =
          Event(title: titleController.text, dayMonth: selectedDate.value);
      addEvent(event);
      Get.back();
    }
  }

  void addEvent(Event event) async {
    await dbProvider.addEvent(event);
    calendarWeekController.onInit();
  }
}
