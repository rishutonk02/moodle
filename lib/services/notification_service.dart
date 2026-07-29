import 'package:moodle/models/announcement.dart';

class NotificationService {
  Future<List<Announcement>> getAnnouncements() async {
    return [
      const Announcement(
        id: 'ann-1',
        title: 'Coursework reminder',
        message: 'Your mobile app coursework is due soon.',
        courseCode: 'CMP5002',
        isRead: false,
      ),
      const Announcement(
        id: 'ann-2',
        title: 'Lecture rescheduled',
        message: 'The Flutter workshop has moved to the main lab.',
        courseCode: 'CMP5002',
        isRead: true,
      ),
    ];
  }

  List<Announcement> getLocalAnnouncements() {
    return [
      const Announcement(
        id: 'local-1',
        title: 'New assessment posted',
        message: 'Check the latest coursework brief.',
        courseCode: 'CMP5002',
        isRead: false,
      ),
    ];
  }
}
