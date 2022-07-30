import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(this._storageRepository) : super(LoadingCalendarState()) {
    on<LoadingCalendarEvent>(_loadingCalendarList);
    on<PickStartTimeEvent>(_pickStartTimeEvent);
    on<PickFinishTimeEvent>(_pickFinishTimeEvent);
    on<ShowTasksEvent>(_showTasksEvent);
    on<AddEventEvent>(_addEventEvent);
    on<GoToViewingPageEvent>(_goToViewingPageEvent);
    on<GoToEditingPageEvent>(_goToEditingPageEvent);
    on<SaveFormEvent>(_saveFormEvent);
    on<DeleteEventEvent>(_deleteEvent);
  }
  final LocalRepository _storageRepository;
  List<Event> eventsFromDB = [];

  void _loadingCalendarList(
      LoadingCalendarEvent event, Emitter<CalendarState> emit) async {
    eventsFromDB = await _storageRepository.getEventsList();
    emit(LoadedCalendarState(events: eventsFromDB));
  }

  void _pickStartTimeEvent(
      PickStartTimeEvent event, Emitter<CalendarState> emit) async {
    DateTime? startEvent = await _storageRepository
        .pickstartEventTime(event.context, pickDate: event.pickDate);
    emit(PickLoadedState(
        startEvent: startEvent, finishEvent: _storageRepository.finishEvent));
  }

  void _pickFinishTimeEvent(
      PickFinishTimeEvent event, Emitter<CalendarState> emit) async {
    DateTime? finishEvent = await _storageRepository
        .pickfinishEventTime(event.context, pickDate: event.pickDate);
    emit(PickLoadedState(
        startEvent: _storageRepository.startEvent, finishEvent: finishEvent));
  }

  void _addEventEvent(AddEventEvent event, Emitter<CalendarState> emit) async {
    emit(AddEventState());
  }

  void _saveFormEvent(SaveFormEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.saveForm(event.text);
    add(LoadingCalendarEvent());
  }

  void _deleteEvent(DeleteEventEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.deleteEvent(event.title);
    add(LoadingCalendarEvent());
  }

  void _showTasksEvent(
      ShowTasksEvent event, Emitter<CalendarState> emit) async {
    emit(
        ShowTasksState(selectedDate: event.selectedDate, events: eventsFromDB));
  }

  void _goToViewingPageEvent(
      GoToViewingPageEvent event, Emitter<CalendarState> emit) async {
    emit(LoadedViewingPageState(selectedEvent: event.selectedEvent));
  }

  void _goToEditingPageEvent(
      GoToEditingPageEvent event, Emitter<CalendarState> emit) async {
    emit(LoadedEditingPageState(selectedEvent: event.selectedEvent));
  }
}
