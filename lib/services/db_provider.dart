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
    String path = join(documentsDirectory.path, "Events.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE LOGIN ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "data TEXT,"
          "start TEXT,"
          "finish TEXT"
          ")");
    });
  }

  addEvent(Event event) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT INTO LOGIN(title, data, start, finish)"
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
    var res = await db.query("LOGIN");
    return res.map((e) => Event.fromDB(e)).toList();
  }

  updateEvent(Event event) async {
    final db = await database;
    await db.rawUpdate(
        "UPDATE LOGIN SET title = ?, data = ?, start = ?, finish = ? WHERE id = ?",
        [
          event.title,
          event.dayMonth.toString(),
          event.startTime.toString(),
          event.finishTime.toString(),
          event.id
        ]);
  }

  deleteEvent(int id) async {
    final db = await database;
    return db.delete("LOGIN", where: "id = ?", whereArgs: [id]);
  }
}
