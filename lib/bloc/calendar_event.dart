import 'package:calendar_of_events/models/event_model.dart';
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

class AddEventEvent extends CalendarEvent {}

class GoToViewingPageEvent extends CalendarEvent {
  final dynamic event;
  GoToViewingPageEvent(this.event);
}

class DeleteEventEvent extends CalendarEvent {
  final String title;
  DeleteEventEvent(this.title);
}
