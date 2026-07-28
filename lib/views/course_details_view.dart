import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final course = CourseService().getCourseById(courseId);

    return AppShell(
      title: course.code,
      body: ResponsivePage(
        children: [
          PageHeader(
            title: course.title,
            subtitle: '${course.code} - Tutor: ${course.tutor}',
            icon: Icons.menu_book_outlined,
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.summary),
                const SizedBox(height: 14),
                LinearProgressIndicator(value: course.progress),
                const SizedBox(height: 8),
                Text('${(course.progress * 100).round()}% course progress'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Course topics',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          ...course.topics.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SectionCard(
                padding: EdgeInsets.zero,
                child: ExpansionTile(
                  title: Text(topic.title),
                  subtitle: Text(topic.description),
                  children: topic.items
                      .map(
                        (item) => ListTile(
                          leading: const Icon(Icons.insert_drive_file_outlined),
                          title: Text(item),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _AssignmentList(assignments: course.assignments),
        ],
      ),
    );
  }
}

class _AssignmentList extends StatelessWidget {
  const _AssignmentList({required this.assignments});

  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assignments',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          ...assignments.map(
            (assignment) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  const Icon(Icons.assignment_outlined, color: moodlePurple),
              title: Text(assignment.title),
              subtitle: Text(
                  'Due ${assignment.dueDate.day}/${assignment.dueDate.month}/${assignment.dueDate.year}'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.assignment,
                arguments: assignment.id,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
