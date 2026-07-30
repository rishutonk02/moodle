import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/calendar_event.dart';

void main() {
  test('calendar event derives the enum name', () {
    const event = CalendarEvent(
      id: 'deadline-1',
      title: 'Coursework brief released',
      courseCode: 'CMP5002',
      date: DateTime(2026, 8, 14),
      type: CalendarEventType.deadline,
    );

    expect(event.name, 'deadline');
    expect(event.courseCode, 'CMP5002');
    expect(event.date.year, 2026);
  });
}
