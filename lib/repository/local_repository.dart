import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/services/db_provider.dart';
import 'package:flutter/material.dart';

class LocalRepository {
  LocalRepository(this._dbProvider);
  final DBProvider _dbProvider;
  List<Event> eventsFromDB = [];
  DateTime startEvent = DateTime.now();
  DateTime finishEvent = DateTime.now().add(const Duration(hours: 2));

  Future<List<Event>> getEventsList() async {
    eventsFromDB = await _dbProvider.getEvents();
    return eventsFromDB;
  }

  Future<DateTime?> pickstartEventTime(BuildContext context,
      {required bool pickDate}) async {
    final date = await pickDateTime(context, startEvent, pickDate: pickDate);
    if (date == null) {
      return startEvent;
    } else {
      if (date.isAfter(finishEvent)) {
        finishEvent = DateTime(
          date.year,
          date.month,
          date.day,
          finishEvent.hour,
          finishEvent.minute,
        );

        return finishEvent;
      }
      startEvent = date;
      return startEvent;
    }
  }

  Future<DateTime?> pickfinishEventTime(BuildContext context,
      {required bool pickDate}) async {
    final date = await pickDateTime(
      context,
      finishEvent,
      pickDate: pickDate,
      firstDate: pickDate ? startEvent : null,
    );
    finishEvent = date ?? finishEvent;
    return finishEvent;
  }

  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2020, 1),
        lastDate: DateTime(2100),
      );
      if (date == null) return null;

      final Duration time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future<void> saveForm(String text) async {
    final event = Event(
      title: text,
      start: startEvent,
      finish: finishEvent,
    );
    _dbProvider.addEvent(event);
  }

  Future<void> deleteEvent(String _title) async {
    await _dbProvider.deleteEvent(_title);
  }
}
