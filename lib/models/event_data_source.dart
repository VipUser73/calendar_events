import 'package:calendar_of_events/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  @override
  DateTime getStartTime(int index) => getEvent(index).start;

  @override
  DateTime getEndTime(int index) => getEvent(index).finish;

  @override
  String getSubject(int index) => getEvent(index).title;
}
