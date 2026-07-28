import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/services/notification_service.dart';
import 'package:moodle/utils/student_details.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/course_card.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final courseService = CourseService();
    final courses = courseService.getCourses(category: 'Current');
    final events = courseService.getCalendarEvents().take(3).toList();
    final announcements = NotificationService().getLocalAnnouncements();

    return AppShell(
      title: 'Dashboard',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Dashboard',
            subtitle:
                'Welcome back, Rishu. Your Moodle activity is up to date.',
            icon: Icons.speed_outlined,
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 900 ? 3 : 1;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: constraints.maxWidth > 900 ? 2.9 : 3.8,
                children: const [
                  _MetricCard(
                    icon: Icons.school_outlined,
                    value: '3',
                    label: 'Active courses',
                  ),
                  _MetricCard(
                    icon: Icons.assignment_outlined,
                    value: '5',
                    label: 'Assessments',
                  ),
                  _MetricCard(
                    icon: Icons.notifications_outlined,
                    value: '2',
                    label: 'Unread notices',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 760;
              final left = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Recently accessed courses',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 12),
                  ...courses.take(2).map(
                        (course) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CourseCard(course: course),
                        ),
                      ),
                ],
              );
              final right = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DashboardList(
                    title: 'Upcoming deadlines',
                    items: events
                        .map((event) =>
                            '${event.courseCode}: ${event.title} (${event.date.day}/${event.date.month})')
                        .toList(),
                    onViewAll: () =>
                        Navigator.pushNamed(context, AppRoutes.calendar),
                  ),
                  const SizedBox(height: 12),
                  _DashboardList(
                    title: 'Latest announcements',
                    items: announcements
                        .take(3)
                        .map((item) => '${item.courseCode}: ${item.title}')
                        .toList(),
                    onViewAll: () =>
                        Navigator.pushNamed(context, AppRoutes.announcements),
                  ),
                ],
              );
              if (!isWide) {
                return Column(
                    children: [left, const SizedBox(height: 12), right]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: left),
                  const SizedBox(width: 18),
                  Expanded(flex: 2, child: right),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          const Text(
            'UP number: ${StudentDetails.upNumber}',
            style: TextStyle(color: moodleTextMuted),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: moodleBlue.withValues(alpha: 0.12),
            child: Icon(icon, color: moodleBlue),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              Text(label),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardList extends StatelessWidget {
  const _DashboardList({
    required this.title,
    required this.items,
    required this.onViewAll,
  });

  final String title;
  final List<String> items;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              TextButton(onPressed: onViewAll, child: const Text('View all')),
            ],
          ),
          ...items.map(
            (item) => ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.chevron_right, color: moodlePurple),
              title: Text(item),
            ),
          ),
        ],
      ),
    );
  }
}
