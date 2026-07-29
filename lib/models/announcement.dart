class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.message,
    required this.courseCode,
    required this.isRead,
  });

  final String id;
  final String title;
  final String message;
  final String courseCode;
  final bool isRead;
}
