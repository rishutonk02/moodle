class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.courseCode,
    required this.createdAt,
    this.isRead = false,
  });

  final String id;
  final String title;
  final String message;
  final String courseCode;
  final DateTime createdAt;
  final bool isRead;

  Map<String, Object?> toFirestore() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'courseCode': courseCode,
      'createdAt': createdAt.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory Announcement.fromFirestore(Map<String, Object?> data) {
    return Announcement(
      id: data['id'] as String? ?? '',
      title: data['title'] as String? ?? 'Announcement',
      message: data['message'] as String? ?? '',
      courseCode: data['courseCode'] as String? ?? 'Moodle',
      createdAt: DateTime.tryParse(data['createdAt'] as String? ?? '') ??
          DateTime.now(),
      isRead: data['isRead'] as bool? ?? false,
    );
  }
}
