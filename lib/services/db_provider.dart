import 'dart:io';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  Database? _database;
  List<Event> eventsFromDB = [];

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "Events.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE LOGIN ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "start TEXT,"
          "finish TEXT"
          ")");
    });
  }

  addEvent(Event event) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO LOGIN(title, start, finish)"
        "VALUES(?, ?, ?)",
        [event.title, event.start.toString(), event.finish.toString()]);
    return raw;
  }

  Future<List<Event>> getEvents() async {
    final db = await database;
    var res = await db.query("LOGIN");
    eventsFromDB = res.map((e) => Event.fromDB(e)).toList();
    return eventsFromDB;
  }

  updateForm(Event event, String name) async {
    final db = await database;
    var raw = await db.rawUpdate(
        "UPDATE LOGIN SET title = ?, start = ?, finish = ? WHERE title = ?",
        [event.title, event.start.toString(), event.finish.toString(), name]);
    return raw;
  }

  deleteEvent(String _title) async {
    final db = await database;
    return db.delete("LOGIN", where: "title = ?", whereArgs: [_title]);
  }
}
