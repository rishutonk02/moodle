import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class AssessmentsView extends StatelessWidget {
  const AssessmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    final service = CourseService();
    final assignments = service.getAssignments();

    return AppShell(
      title: 'Assessments',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Assessments',
            subtitle: 'Review due dates, grades and submission status.',
            icon: Icons.assignment_outlined,
          ),
          const SizedBox(height: 16),
          ...assignments.map((assignment) {
            final course = service.getCourseById(assignment.courseId);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SectionCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: moodleGrayBg,
                    child:
                        Icon(Icons.description_outlined, color: moodlePurple),
                  ),
                  title: Text(assignment.title),
                  subtitle: Text(
                    '${course.code} - Due ${assignment.dueDate.day}/${assignment.dueDate.month}/${assignment.dueDate.year} - ${assignment.points} points',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.assignment,
                    arguments: assignment.id,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
