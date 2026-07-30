import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/services/notification_service.dart';

void main() {
  test('notification service exposes the local announcement feed', () {
    final announcements = NotificationService().getLocalAnnouncements();

    expect(announcements, hasLength(1));
    expect(announcements.single.courseCode, 'CMP5002');
    expect(announcements.single.isRead, isFalse);
  });

  test('notification service returns remote announcements', () async {
    final announcements = await NotificationService().getAnnouncements();

    expect(announcements, hasLength(2));
    expect(
      announcements.map((announcement) => announcement.title),
      contains('Coursework reminder'),
    );
  });
}
