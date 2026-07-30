import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/services/notification_service.dart';

void main() {
  test('notification service exposes the local announcement feed', () {
    final announcements = NotificationService().getLocalAnnouncements();

    expect(announcements, hasLength(3));
    expect(announcements.first.courseCode, 'Moodle');
    expect(announcements.first.isRead, isFalse);
    expect(
      announcements.map((announcement) => announcement.title),
      contains('Firebase configuration'),
    );
  });

  test('notification service returns remote announcements', () async {
    final announcements = await NotificationService().getAnnouncements();

    expect(announcements, hasLength(3));
    expect(
      announcements.map((announcement) => announcement.title),
      contains('Welcome back to Moodle'),
    );
  });
}
