import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/services/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarWeekController extends GetxController with StateMixin {
  final dbProvider = DBProvider();

  DateTime firstDayOfWeek = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day - (DateTime.now().weekday + 20));
  RxList<Event> eventsFromDB = <Event>[].obs;

  @override
  void onInit() {
    debugPrint('CalendarWeekController.onInit');
    super.onInit();

    dbProvider.getEvents().then((response) {
      eventsFromDB.value = response;
      //update();
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
