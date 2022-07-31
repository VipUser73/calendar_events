import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(this._storageRepository) : super(LoadingCalendarState()) {
    on<LoadingCalendarEvent>(_loadingCalendarList);
    on<PickTimeEvent>(_pickTimeEvent);
    on<PickTimeEditEvent>(_pickTimeEditEvent);
    on<AddEventEvent>(_addEventEvent);
    on<GoToViewingPageEvent>(_goToViewingPageEvent);
    on<GoToBackEvent>(_goToBackEvent);
    on<GoToEditingPageEvent>(_goToEditingPageEvent);
    on<SaveFormEvent>(_saveFormEvent);
    on<UpdateFormEvent>(_updateFormEvent);
    on<DeleteEventEvent>(_deleteEvent);
  }
  final LocalRepository _storageRepository;
  List<Event> eventsFromDB = [];
  Event selectedEvent = Event(
      title: '',
      start: DateTime.now(),
      finish: DateTime.now().add(const Duration(hours: 2)));
  String name = '';

  void _loadingCalendarList(
      LoadingCalendarEvent event, Emitter<CalendarState> emit) async {
    eventsFromDB = await _storageRepository.getEventsList();
    emit(LoadedCalendarState(events: eventsFromDB));
  }

  void _pickTimeEvent(PickTimeEvent event, Emitter<CalendarState> emit) async {
    emit(PickLoadedState(
        startEvent: event.startEvent, finishEvent: event.finishEvent));
  }

  void _pickTimeEditEvent(
      PickTimeEditEvent event, Emitter<CalendarState> emit) async {
    emit(PickLoadedEditState(selectedEvent: event.selectedEvent));
  }

  void _addEventEvent(AddEventEvent event, Emitter<CalendarState> emit) async {
    emit(AddEventState());
  }

  void _saveFormEvent(SaveFormEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.saveForm(event.saveEvent);
    add(LoadingCalendarEvent());
  }

  void _updateFormEvent(
      UpdateFormEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.updateForm(event.updateEvent, name);
  }

  void _deleteEvent(DeleteEventEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.deleteEvent(event.title);
    add(LoadingCalendarEvent());
  }

  void _goToViewingPageEvent(
      GoToViewingPageEvent event, Emitter<CalendarState> emit) async {
    selectedEvent = event.selectedEvent;
    emit(LoadedViewingPageState(selectedEvent: selectedEvent));
  }

  void _goToBackEvent(GoToBackEvent event, Emitter<CalendarState> emit) async {
    emit(LoadedViewingPageState(selectedEvent: selectedEvent));
  }

  void _goToEditingPageEvent(
      GoToEditingPageEvent event, Emitter<CalendarState> emit) async {
    name = event.name;
    emit(LoadedEditingPageState(selectedEvent: selectedEvent, name: name));
  }
}
