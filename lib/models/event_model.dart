class Event {
  int? id;
  String title;
  DateTime dayMonth;
  DateTime? startTime;
  DateTime? finishTime;
  bool isDone;

  Event({
    this.id,
    required this.title,
    required this.dayMonth,
    this.startTime,
    this.finishTime,
    this.isDone = false,
  });
  factory Event.fromDB(Map<String, dynamic> dataDB) => Event(
        id: dataDB["id"],
        title: dataDB["title"],
        dayMonth: DateTime.parse(dataDB["data"]),
        startTime: DateTime.tryParse(dataDB["start"]),
        finishTime: DateTime.tryParse(dataDB["finish"]),
        isDone: dataDB["status"] == 1 ? true : false,
      );
}
