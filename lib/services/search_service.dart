import 'package:moodle/models/announcement.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/models/search_result.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/services/notification_service.dart';

class SearchService {
  SearchService({
    CourseService? courseService,
    NotificationService? notificationService,
  })  : _courseService = courseService ?? CourseService(),
        _notificationService = notificationService ?? NotificationService();

  final CourseService _courseService;
  final NotificationService _notificationService;

  Future<List<SearchResult>> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const [];
    }

    final courses = _courseService.getCourses();
    final announcements = await _notificationService.getAnnouncements();

    return [
      ..._courseResults(courses, normalized),
      ..._assignmentResults(courses, normalized),
      ..._resourceResults(courses, normalized),
      ..._notificationResults(announcements, normalized),
    ];
  }

  Iterable<SearchResult> _courseResults(List<Course> courses, String query) {
    return courses.where((course) {
      return _matches(query, [course.title, course.code, course.summary]);
    }).map(
      (course) => SearchResult(
        title: course.title,
        subtitle: '${course.code} course',
        type: SearchResultType.course,
        route: AppRoutes.courseDetails,
        arguments: course.id,
      ),
    );
  }

  Iterable<SearchResult> _assignmentResults(
    List<Course> courses,
    String query,
  ) {
    return courses.expand((course) {
      return course.assignments.where((assignment) {
        return _matches(query, [assignment.title, assignment.description]);
      }).map(
        (assignment) => SearchResult(
          title: assignment.title,
          subtitle: '${course.code} assignment',
          type: SearchResultType.assignment,
          route: AppRoutes.assignment,
          arguments: assignment.id,
        ),
      );
    });
  }

  Iterable<SearchResult> _resourceResults(List<Course> courses, String query) {
    return courses.expand((course) {
      return course.resources.where((resource) {
        return _matches(query, [resource.title]);
      }).map(
        (resource) => SearchResult(
          title: resource.title,
          subtitle: '${course.code} resource',
          type: SearchResultType.resource,
          route: AppRoutes.courseDetails,
          arguments: course.id,
        ),
      );
    });
  }

  Iterable<SearchResult> _notificationResults(
    List<Announcement> announcements,
    String query,
  ) {
    return announcements.where((announcement) {
      return _matches(query, [
        announcement.title,
        announcement.message,
        announcement.courseCode,
      ]);
    }).map(
      (announcement) => SearchResult(
        title: announcement.title,
        subtitle: '${announcement.courseCode} notification',
        type: SearchResultType.notification,
        route: AppRoutes.notifications,
      ),
    );
  }

  bool _matches(String query, List<String> values) {
    return values.any((value) => value.toLowerCase().contains(query));
  }
}
