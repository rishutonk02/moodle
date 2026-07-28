import 'package:flutter/material.dart';
import 'package:moodle/views/announcements_view.dart';
import 'package:moodle/views/assignment_view.dart';
import 'package:moodle/views/assessments_view.dart';
import 'package:moodle/views/calendar_view.dart';
import 'package:moodle/views/course_details_view.dart';
import 'package:moodle/views/courses_view.dart';
import 'package:moodle/views/dashboard_view.dart';
import 'package:moodle/views/login_view.dart';
import 'package:moodle/views/notifications_view.dart';
import 'package:moodle/views/profile_view.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String login = '/login';
  static const String courses = '/courses';
  static const String courseDetails = '/courses/details';
  static const String assessments = '/assessments';
  static const String assignment = '/assignment';
  static const String calendar = '/calendar';
  static const String notifications = '/notifications';
  static const String announcements = '/announcements';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );
      case courses:
        return MaterialPageRoute(
          builder: (_) => const CoursesView(),
          settings: settings,
        );
      case courseDetails:
        return MaterialPageRoute(
          builder: (_) => CourseDetailsView(
            courseId: settings.arguments as String,
          ),
          settings: settings,
        );
      case assessments:
        return MaterialPageRoute(
          builder: (_) => const AssessmentsView(),
          settings: settings,
        );
      case assignment:
        return MaterialPageRoute(
          builder: (_) => AssignmentView(
            assignmentId: settings.arguments as String,
          ),
          settings: settings,
        );
      case calendar:
        return MaterialPageRoute(
          builder: (_) => const CalendarView(),
          settings: settings,
        );
      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsView(),
          settings: settings,
        );
      case announcements:
        return MaterialPageRoute(
          builder: (_) => const AnnouncementsView(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardView(),
          settings: settings,
        );
    }
  }
}
