class Event {
  final String title;
  final DateTime start;
  final DateTime finish;

  Event({
    required this.title,
    required this.start,
    required this.finish,
  });
  factory Event.fromDB(Map<String, dynamic> dataDB) => Event(
        title: dataDB["title"] ?? '',
        start: DateTime.parse(dataDB["start"]),
        finish: DateTime.parse(dataDB["finish"]),
      );
}
