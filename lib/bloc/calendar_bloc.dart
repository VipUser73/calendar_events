import 'package:calendar_of_events/bloc/calendar_event.dart';
import 'package:calendar_of_events/bloc/calendar_state.dart';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/repository/local_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc(this._storageRepository)
      : super(LoadingCalendarState(
            events: _storageRepository.eventsFromDB,
            startEvent: _storageRepository.startEvent,
            finishEvent: _storageRepository.finishEvent)) {
    on<LoadingCalendarEvent>(_loadingCalendarList);
    on<PickStartTimeEvent>(_pickStartTimeEvent);
    on<PickFinishTimeEvent>(_pickFinishTimeEvent);
    on<SaveFormEvent>(_saveFormEvent);
  }
  final LocalRepository _storageRepository;

  void _loadingCalendarList(
      LoadingCalendarEvent event, Emitter<CalendarState> emit) async {
    List<Event> eventsFromDB = await _storageRepository.getEventsList();
    emit(LoadedCalendarState(
        events: eventsFromDB,
        startEvent: _storageRepository.startEvent,
        finishEvent: _storageRepository.finishEvent));
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

  void _saveFormEvent(SaveFormEvent event, Emitter<CalendarState> emit) async {
    await _storageRepository.saveForm(event.text);
    emit(PickLoadedState(startEvent: _storageRepository.startEvent));
  }

  // void _deleteEvent(DeleteCalendarEvent event, Emitter<CalendarState> emit) async {
  //   await _storageRepository.deleteEvent(event.cityName);
  //   _updateCalendar();
  // }

}
