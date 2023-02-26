import 'dart:io';
import 'package:calendar_of_events/models/event_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, "Event.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE EVENTS ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "data TEXT,"
          "start TEXT,"
          "finish TEXT,"
          "status INTEGER"
          ")");
    });
  }

  addEvent(Event event) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO EVENTS(title, data, start, finish)"
        "VALUES(?, ?, ?, ?)",
        [
          event.title,
          event.dayMonth.toString(),
          event.startTime?.toString() ?? '',
          event.finishTime?.toString() ?? ''
        ]);
    return raw;
  }

  Future<List<Event>> getEvents() async {
    final db = await database;
    var res = await db.query("EVENTS");
    return res.map((e) => Event.fromDB(e)).toList();
  }

  Future<List<Event>> getSelectEvents(String data) async {
    final db = await database;
    var res = await db.query("EVENTS", where: 'data = ?', whereArgs: [data]);
    return res.map((e) => Event.fromDB(e)).toList();
  }

  updateEvent(Event event) async {
    final db = await database;
    await db.rawUpdate(
        "UPDATE EVENTS SET title = ?, data = ?, start = ?, finish = ? WHERE id = ?",
        [
          event.title,
          event.dayMonth.toString(),
          event.startTime.toString(),
          event.finishTime.toString(),
          event.id
        ]);
  }

  updateStatus(int? id, int status) async {
    final db = await database;
    await db
        .rawUpdate("UPDATE EVENTS SET status = ? WHERE id = ?", [status, id]);
  }

  deleteEvent(int id) async {
    final db = await database;
    return db.delete("EVENTS", where: "id = ?", whereArgs: [id]);
  }
}
