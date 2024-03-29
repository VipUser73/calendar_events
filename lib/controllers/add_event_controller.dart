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
  final RxList<Event> eventsList = <Event>[].obs;
  int? currentIndex;
  final flag = false.obs;
  final isEdit = false.obs;

  void findEvents() async {
    // eventsList.value = calendarWeekController.eventsFromDB
    //     .where((element) => element.dayMonth == selectedDate.value)
    //     .toList();
    // eventsList.sort((a, b) =>
    //     (a.startTime ?? a.dayMonth).compareTo(b.startTime ?? b.dayMonth));

    eventsList.value =
        await dbProvider.getSelectEvents(selectedDate.toString());
  }

  static DateTime currentDateTime = DateTime.now();

  final Rx<DateTime> selectedDate = DateTime(
    currentDateTime.year,
    currentDateTime.month,
    currentDateTime.day,
  ).obs;

  final Rx<DateTime> selectedStartTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute)
      .obs;
  final Rx<DateTime> selectedFinishTime = DateTime(
          currentDateTime.year,
          currentDateTime.month,
          currentDateTime.day,
          currentDateTime.hour,
          currentDateTime.minute)
      .obs;
  Future<void> saveForm() async {
    final bool? isValid = formKey.currentState?.validate();
    if (isValid == true) {
      final event = Event(
        id: currentIndex != null ? eventsList[currentIndex!].id : null,
        title: titleController.text,
        dayMonth: selectedDate.value,
        startTime: flag.value ? selectedStartTime.value : null,
        finishTime: flag.value ? selectedFinishTime.value : null,
        isDone: currentIndex != null ? eventsList[currentIndex!].isDone : false,
      );
      isEdit.value ? saveUpdateEvent(event) : saveAddEvent(event);
    }
    isEdit.value = false;
  }

  void saveAddEvent(Event event) async {
    await dbProvider.addEvent(event);
    findEvents();
    titleController.clear();
  }

  void updateEvent(int index) async {
    final event = eventsList[index];
    isEdit.value = true;
    currentIndex = index;
    titleController.text = event.title;
    if (event.startTime != null && event.finishTime != null) {
      flag.value = true;
      selectedStartTime.value = event.startTime!;
      selectedFinishTime.value = event.finishTime!;
    }
  }

  void updateStatus(int index) async {
    eventsList[index].isDone = !eventsList[index].isDone;
    eventsList.refresh();
    await dbProvider.updateStatus(
        eventsList[index].id, eventsList[index].isDone ? 1 : 0);
  }

  void saveUpdateEvent(Event event) async {
    await dbProvider.updateEvent(event);
    titleController.clear();
    final index = eventsList.indexWhere((element) => element.id == event.id);
    eventsList[index] = event;
  }

  void deleteEvent(int index) async {
    await dbProvider.deleteEvent(eventsList[index].id!);
    eventsList.removeAt(index);
  }
}
