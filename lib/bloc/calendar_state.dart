import 'package:calendar_of_events/models/event_model.dart';

abstract class CalendarState {
  final List<Event> events;
  final DateTime? startEvent;
  final DateTime? finishEvent;
  CalendarState({this.events = const [], this.startEvent, this.finishEvent});
}

class LoadingCalendarState extends CalendarState {
  LoadingCalendarState(
      {required List<Event> events,
      required DateTime? startEvent,
      required DateTime? finishEvent})
      : super(events: events, startEvent: startEvent, finishEvent: finishEvent);
}

class LoadedCalendarState extends CalendarState {
  LoadedCalendarState(
      {required List<Event> events,
      required DateTime? startEvent,
      required DateTime? finishEvent})
      : super(events: events, startEvent: startEvent, finishEvent: finishEvent);
}

class PickLoadedState extends CalendarState {
  PickLoadedState({DateTime? startEvent, DateTime? finishEvent})
      : super(startEvent: startEvent, finishEvent: finishEvent);
}
