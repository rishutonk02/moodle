class Course {
  const Course({
    required this.id,
    required this.code,
    required this.title,
    required this.tutor,
    required this.summary,
    required this.progress,
    required this.topics,
    required this.assignments,
  });

  final String id;
  final String code;
  final String title;
  final String tutor;
  final String summary;
  final double progress;
  final List<CourseTopic> topics;
  final List<Assignment> assignments;
}

class CourseTopic {
  const CourseTopic({
    required this.title,
    required this.description,
    required this.items,
  });

  final String title;
  final String description;
  final List<String> items;
}

class Assignment {
  const Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.points,
    required this.dueDate,
  });

  final String id;
  final String courseId;
  final String title;
  final String description;
  final int points;
  final DateTime dueDate;
}
