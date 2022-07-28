import 'package:flutter/material.dart';

abstract class CalendarEvent {}

class LoadingCalendarEvent extends CalendarEvent {}

class PickStartTimeEvent extends CalendarEvent {
  BuildContext context;
  bool pickDate;
  PickStartTimeEvent(this.context, {required this.pickDate});
}

class PickFinishTimeEvent extends CalendarEvent {
  BuildContext context;
  bool pickDate;
  PickFinishTimeEvent(this.context, {required this.pickDate});
}

class SaveFormEvent extends CalendarEvent {
  final String text;
  SaveFormEvent(this.text);
}

class ShowTasksEvent extends CalendarEvent {
  final DateTime selectedDate;
  ShowTasksEvent(this.selectedDate);
}
