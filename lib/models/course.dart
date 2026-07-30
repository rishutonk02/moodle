class Course {
  const Course({
    required this.id,
    required this.code,
    required this.title,
    required this.summary,
    required this.tutor,
    required this.progress,
    required this.category,
    required this.topics,
    required this.assignments,
    required this.resources,
  });

  final String id;
  final String code;
  final String title;
  final String summary;
  final String tutor;
  final double progress;
  final String category;
  final List<CourseTopic> topics;
  final List<Assignment> assignments;
  final List<ResourceItem> resources;
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
    required this.dueDate,
    required this.status,
    required this.points,
  });

  final String id;
  final String courseId;
  final String title;
  final String description;
  final DateTime dueDate;
  final AssignmentStatus status;
  final int points;
}

enum AssignmentStatus { notStarted, draft, submitted, graded }

class ResourceItem {
  const ResourceItem({
    required this.id,
    required this.courseId,
    required this.title,
    required this.type,
  });

  final String id;
  final String courseId;
  final String title;
  final ResourceType type;
}

enum ResourceType { file, video, link, quiz }
