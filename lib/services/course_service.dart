import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/models/course.dart';

class CourseService {
  CourseService();

  final List<Course> _courses = _dummyCourses;

  List<Course> getCourses({String query = '', String category = 'All'}) {
    final normalizedQuery = query.trim().toLowerCase();
    return _courses.where((course) {
      final matchesQuery = normalizedQuery.isEmpty ||
          course.title.toLowerCase().contains(normalizedQuery) ||
          course.code.toLowerCase().contains(normalizedQuery) ||
          course.summary.toLowerCase().contains(normalizedQuery);
      final matchesCategory = category == 'All' || course.category == category;
      return matchesQuery && matchesCategory;
    }).toList(growable: false);
  }

  List<String> getCategories() {
    return ['All', ..._courses.map((course) => course.category).toSet()];
  }

  Course getCourseById(String id) {
    return _courses.firstWhere((course) => course.id == id);
  }

  List<Assignment> getAssignments() {
    return _courses.expand((course) => course.assignments).toList();
  }

  Assignment getAssignmentById(String id) {
    return getAssignments().firstWhere((assignment) => assignment.id == id);
  }

  List<ResourceItem> getResources() {
    return _courses.expand((course) => course.resources).toList();
  }

  List<CalendarEvent> getCalendarEvents() {
    final assignmentEvents = getAssignments().map(
      (assignment) => CalendarEvent(
        id: assignment.id,
        title: assignment.title,
        courseCode: getCourseById(assignment.courseId).code,
        date: assignment.dueDate,
        type: CalendarEventType.deadline,
      ),
    );

    return [
      ...assignmentEvents,
      CalendarEvent(
        id: 'brief-deadline',
        title: 'Coursework repository submission deadline',
        courseCode: 'UP Moodle',
        date: DateTime(2026, 8, 14, 16, 0),
        type: CalendarEventType.deadline,
      ),
      CalendarEvent(
        id: 'demo-booking',
        title: 'Book and attend online demonstration',
        courseCode: 'UP Moodle',
        date: DateTime(2026, 8, 21, 10, 0),
        type: CalendarEventType.tutorial,
      ),
    ]..sort((a, b) => a.date.compareTo(b.date));
  }
}

final List<Course> _dummyCourses = [
  Course(
    id: 'web-mobile',
    code: 'CTEC3905',
    title: 'Mobile Application Development',
    summary:
        'Build a Moodle-style Flutter application using maintainable Dart architecture.',
    tutor: 'Dr Mani Ghahremani',
    progress: 0.76,
    category: 'Current',
    topics: const [
      CourseTopic(
        title: 'Week 1: Flutter foundations',
        description: 'Widgets, layout constraints, state and navigation.',
        items: ['Lecture slides', 'Starter lab', 'Material 3 reading'],
      ),
      CourseTopic(
        title: 'Week 2: Moodle coursework',
        description: 'Responsive screens, data models, services and testing.',
        items: ['Coursework brief', 'Demo checklist', 'Submission guidance'],
      ),
      CourseTopic(
        title: 'Week 3: Firebase integration',
        description:
            'Authentication, Firestore collections and security rules.',
        items: [
          'Firebase Auth guide',
          'Firestore model examples',
          'Rules draft'
        ],
      ),
    ],
    assignments: [
      Assignment(
        id: 'moodle-coursework',
        courseId: 'web-mobile',
        title: 'Moodle Mobile Coursework',
        description:
            'Submit the completed Flutter repository link and demonstrate the app.',
        dueDate: DateTime(2026, 8, 14, 16, 0),
        status: AssignmentStatus.draft,
        points: 100,
      ),
      Assignment(
        id: 'firebase-evidence',
        courseId: 'web-mobile',
        title: 'Firebase setup evidence',
        description:
            'Document Firebase configuration and show the app using authentication.',
        dueDate: DateTime(2026, 8, 10, 12, 0),
        status: AssignmentStatus.notStarted,
        points: 20,
      ),
    ],
    resources: const [
      ResourceItem(
        id: 'brief',
        courseId: 'web-mobile',
        title: 'Coursework brief',
        type: ResourceType.file,
      ),
      ResourceItem(
        id: 'flutter-layout',
        courseId: 'web-mobile',
        title: 'Responsive Flutter layouts',
        type: ResourceType.video,
      ),
    ],
  ),
  Course(
    id: 'software-engineering',
    code: 'CTEC2904',
    title: 'Software Engineering Practice',
    summary:
        'Plan, test and document maintainable software with professional workflows.',
    tutor: 'Prof Alex Carter',
    progress: 0.54,
    category: 'Current',
    topics: const [
      CourseTopic(
        title: 'Testing strategy',
        description: 'Unit, widget and integration test planning.',
        items: ['Test pyramid notes', 'Widget test lab'],
      ),
      CourseTopic(
        title: 'Git practice',
        description: 'Meaningful commits, code review and release notes.',
        items: ['Commit guide', 'Branching exercise'],
      ),
    ],
    assignments: [
      Assignment(
        id: 'testing-report',
        courseId: 'software-engineering',
        title: 'Testing report',
        description: 'Explain the tests added to a mobile application.',
        dueDate: DateTime(2026, 8, 6, 15, 0),
        status: AssignmentStatus.notStarted,
        points: 40,
      ),
    ],
    resources: const [
      ResourceItem(
        id: 'quality-checklist',
        courseId: 'software-engineering',
        title: 'Code quality checklist',
        type: ResourceType.link,
      ),
    ],
  ),
  Course(
    id: 'databases',
    code: 'CTEC2806',
    title: 'Databases and Cloud Data',
    summary:
        'Design relational and cloud-hosted data stores for real applications.',
    tutor: 'Dr Priya Shah',
    progress: 0.42,
    category: 'Archive',
    topics: const [
      CourseTopic(
        title: 'Cloud collections',
        description: 'Document data, indexing and security.',
        items: ['Firestore overview', 'Security rules worksheet'],
      ),
    ],
    assignments: [
      Assignment(
        id: 'firestore-models',
        courseId: 'databases',
        title: 'Firestore data model',
        description: 'Create and explain a NoSQL data model.',
        dueDate: DateTime(2026, 8, 18, 13, 0),
        status: AssignmentStatus.notStarted,
        points: 30,
      ),
    ],
    resources: const [
      ResourceItem(
        id: 'firestore-indexes',
        courseId: 'databases',
        title: 'Firestore indexing guide',
        type: ResourceType.file,
      ),
    ],
  ),
];
