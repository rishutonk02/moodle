import 'package:moodle/models/calendar_event.dart';
import 'package:moodle/models/course.dart';

class CourseService {
  List<Course> getCourses({String? query, String? category}) {
    final courses = <Course>[
      Course(
        id: 'mobile-app-dev',
        code: 'CMP5002',
        title: 'Mobile Application Development',
        tutor: 'Dr. A. Khan',
        summary:
            'Build responsive mobile applications and learn cross-platform UI patterns.',
        progress: 0.78,
        topics: const [
          CourseTopic(
            title: 'Flutter essentials',
            description: 'State management, navigation and widgets.',
            items: ['Widget tree', 'Routes', 'theme'],
          ),
          CourseTopic(
            title: 'Backend integration',
            description: 'Authentication and cloud services.',
            items: ['Firebase setup evidence', 'Firestore data model'],
          ),
        ],
        assignments: [
          Assignment(
            id: 'moodle-coursework',
            courseId: 'mobile-app-dev',
            title: 'Coursework submission',
            description:
                'Submit the mobile app coursework with working navigation and data handling.',
            points: 40,
            dueDate: DateTime(2026, 8, 14),
          ),
          Assignment(
            id: 'lab-1',
            courseId: 'mobile-app-dev',
            title: 'Lab challenge',
            description: 'Complete the practical lab tasks and upload evidence.',
            points: 20,
            dueDate: DateTime(2026, 8, 21),
          ),
        ],
      ),
      Course(
        id: 'databases-cloud',
        code: 'CMP5003',
        title: 'Databases and Cloud Data',
        tutor: 'Prof. S. Patel',
        summary: 'Explore relational design and cloud based data storage.',
        progress: 0.63,
        topics: const [
          CourseTopic(
            title: 'Schema design',
            description: 'Normalisation and indexing.',
            items: ['Firestore indexing guide', 'SQL joins'],
          ),
        ],
        assignments: [
          Assignment(
            id: 'data-lab',
            courseId: 'databases-cloud',
            title: 'Database lab report',
            description:
                'Write up the database design and record your implementation steps.',
            points: 30,
            dueDate: DateTime(2026, 8, 12),
          ),
        ],
      ),
    ];

    var filtered = courses.where((course) {
      final searchText =
          '${course.title} ${course.code} ${course.summary}'.toLowerCase();
      final matchesQuery = query == null ||
          query.isEmpty ||
          searchText.contains(query.toLowerCase());
      final matchesCategory = category == null ||
          category.isEmpty ||
          category == 'All' ||
          course.code.startsWith(category);
      return matchesQuery && matchesCategory;
    }).toList();

    return filtered;
  }

  List<String> getCategories() => ['All', 'CMP5'];

  Course getCourseById(String id) {
    return getCourses().firstWhere(
      (course) => course.id == id,
      orElse: () => getCourses().first,
    );
  }

  List<CalendarEvent> getCalendarEvents() {
    return [
      CalendarEvent(
        id: 'brief-deadline',
        title: 'Coursework brief released',
        courseCode: 'CMP5002',
        date: DateTime(2026, 8, 14, 16, 0),
        type: CalendarEventType.deadline,
      ),
      CalendarEvent(
        id: 'lecture-1',
        title: 'Flutter UI workshop',
        courseCode: 'CMP5002',
        date: DateTime(2026, 8, 16, 10, 0),
        type: CalendarEventType.lecture,
      ),
      CalendarEvent(
        id: 'tutorial-2',
        title: 'Cloud storage tutorial',
        courseCode: 'CMP5003',
        date: DateTime(2026, 8, 18, 13, 0),
        type: CalendarEventType.tutorial,
      ),
    ];
  }

  List<Assignment> getAssignments() {
    return getCourses().expand((course) => course.assignments).toList();
  }

  Assignment getAssignmentById(String id) {
    return getAssignments().firstWhere((assignment) => assignment.id == id);
  }

  List<Assignment> getAssignmentsForCourse(String courseId) {
    return getCourses()
        .firstWhere((course) => course.id == courseId)
        .assignments;
  }
}
