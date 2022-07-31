import 'package:calendar_of_events/models/event_model.dart';

abstract class CalendarState {
  List<Event> events;
  String name;
  Event? selectedEvent;
  final DateTime? startEvent;
  final DateTime? finishEvent;
  CalendarState({
    this.events = const [],
    this.name = '',
    this.selectedEvent,
    this.startEvent,
    this.finishEvent,
  });
}

class LoadingCalendarState extends CalendarState {}

class LoadedCalendarState extends CalendarState {
  LoadedCalendarState({required List<Event> events}) : super(events: events);
}

class PickLoadedState extends CalendarState {
  PickLoadedState({DateTime? startEvent, DateTime? finishEvent})
      : super(startEvent: startEvent, finishEvent: finishEvent);
}

class PickLoadedEditState extends CalendarState {
  PickLoadedEditState({final Event? selectedEvent})
      : super(selectedEvent: selectedEvent);
}

class AddEventState extends CalendarState {}

class GoToBackState extends CalendarState {
  GoToBackState({required Event selectedEvent})
      : super(selectedEvent: selectedEvent);
}

class LoadedEditingPageState extends CalendarState {
  LoadedEditingPageState({required Event selectedEvent, required String name})
      : super(selectedEvent: selectedEvent, name: name);
}

class LoadedViewingPageState extends CalendarState {
  LoadedViewingPageState({required Event selectedEvent})
      : super(selectedEvent: selectedEvent);
}
