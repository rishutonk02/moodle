import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodle/models/announcement.dart';

class NotificationService {
  NotificationService({FirebaseFirestore? firestore}) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  List<Announcement> getLocalAnnouncements() {
    return [
      Announcement(
        id: 'welcome',
        title: 'Welcome back to Moodle',
        message:
            'Your dashboard has been refreshed with current courses and deadlines.',
        courseCode: 'Moodle',
        createdAt: DateTime(2026, 7, 24, 9, 0),
      ),
      Announcement(
        id: 'coursework',
        title: 'Coursework submission reminder',
        message:
            'Submit the public repository link before the coursework deadline.',
        courseCode: 'CTEC3905',
        createdAt: DateTime(2026, 7, 23, 14, 30),
      ),
      Announcement(
        id: 'firebase',
        title: 'Firebase configuration',
        message:
            'Remember to add Firebase app credentials before demonstrating live authentication.',
        courseCode: 'CTEC3905',
        createdAt: DateTime(2026, 7, 21, 11, 0),
        isRead: true,
      ),
    ];
  }

  Future<List<Announcement>> getAnnouncements() async {
    final firestore = _firestore;
    if (firestore == null) {
      return getLocalAnnouncements();
    }

    try {
      final snapshot = await firestore
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .get();
      if (snapshot.docs.isEmpty) {
        return getLocalAnnouncements();
      }
      return snapshot.docs
          .map((doc) => Announcement.fromFirestore(doc.data()))
          .toList();
    } catch (_) {
      return getLocalAnnouncements();
    }
  }
}
