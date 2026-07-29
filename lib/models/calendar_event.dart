enum CalendarEventType { deadline, lecture, tutorial, feedback }

class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.courseCode,
    required this.date,
    required this.type,
  });

  final String id;
  final String title;
  final String courseCode;
  final DateTime date;
  final CalendarEventType type;

  String get name => type.name;
}
