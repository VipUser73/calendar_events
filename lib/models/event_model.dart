class Event {
  String title;
  DateTime dayMonth;
  DateTime? startTime;
  DateTime? finishTime;

  Event({
    required this.title,
    required this.dayMonth,
    this.startTime,
    this.finishTime,
  });
  factory Event.fromDB(Map<String, dynamic> dataDB) => Event(
        title: dataDB["title"],
        dayMonth: DateTime.parse(dataDB["data"]),
        startTime: DateTime.tryParse(dataDB["start"]),
        finishTime: DateTime.tryParse(dataDB["finish"]),
      );
}
