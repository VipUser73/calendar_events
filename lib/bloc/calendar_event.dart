import 'package:calendar_of_events/models/event_model.dart';

abstract class CalendarEvent {}

class LoadingCalendarEvent extends CalendarEvent {}

class PickTimeEvent extends CalendarEvent {
  DateTime startEvent;
  DateTime finishEvent;
  PickTimeEvent(this.startEvent, this.finishEvent);
}

class PickTimeEditEvent extends CalendarEvent {
  final Event selectedEvent;
  PickTimeEditEvent(this.selectedEvent);
}

class SaveFormEvent extends CalendarEvent {
  final Event saveEvent;
  SaveFormEvent(this.saveEvent);
}

class ShowTasksEvent extends CalendarEvent {
  final DateTime selectedDate;
  ShowTasksEvent(this.selectedDate);
}

class AddEventEvent extends CalendarEvent {}

class GoToViewingPageEvent extends CalendarEvent {
  final Event selectedEvent;
  GoToViewingPageEvent(this.selectedEvent);
}

class GoToEditingPageEvent extends CalendarEvent {
  final String name;
  GoToEditingPageEvent(this.name);
}

class GoToBackEvent extends CalendarEvent {}

class UpdateFormEvent extends CalendarEvent {
  final Event updateEvent;
  UpdateFormEvent(this.updateEvent);
}

class DeleteEventEvent extends CalendarEvent {
  final String title;
  DeleteEventEvent(this.title);
}
