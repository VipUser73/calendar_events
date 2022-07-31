import 'package:calendar_of_events/models/event_model.dart';
import 'package:calendar_of_events/services/db_provider.dart';

class LocalRepository {
  LocalRepository(this._dbProvider);
  final DBProvider _dbProvider;
  List<Event> eventsFromDB = [];

  Future<List<Event>> getEventsList() async {
    eventsFromDB = await _dbProvider.getEvents();
    return eventsFromDB;
  }

  Future<void> saveForm(Event seveEvent) async {
    _dbProvider.addEvent(seveEvent);
  }

  Future<void> updateForm(Event seveEvent, String name) async {
    _dbProvider.updateForm(seveEvent, name);
  }

  Future<void> deleteEvent(String _title) async {
    await _dbProvider.deleteEvent(_title);
  }
}
