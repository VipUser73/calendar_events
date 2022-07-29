import 'package:calendar_of_events/models/event_model.dart';

abstract class CalendarState {
  List<Event> events;
  final DateTime? selectedDate;
  final DateTime? startEvent;
  final DateTime? finishEvent;
  CalendarState(
      {this.events = const [],
      this.startEvent,
      this.finishEvent,
      this.selectedDate});
}

class LoadingCalendarState extends CalendarState {}

class LoadedCalendarState extends CalendarState {
  LoadedCalendarState({required List<Event> events}) : super(events: events);
}

class PickLoadedState extends CalendarState {
  PickLoadedState({DateTime? startEvent, DateTime? finishEvent})
      : super(startEvent: startEvent, finishEvent: finishEvent);
}

class ShowTasksState extends CalendarState {
  ShowTasksState({required List<Event> events, required DateTime? selectedDate})
      : super(events: events, selectedDate: selectedDate);
}

class AddEventState extends CalendarState {}
