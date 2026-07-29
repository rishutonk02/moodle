import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/routes/app_routes.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: moodleWhite,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.courseDetails,
            arguments: course.id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: moodleBlue.withValues(alpha: 0.12),
                    child: const Icon(Icons.school_outlined, color: moodleBlue),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      course.code,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(course.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(course.summary,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 12),
              Text('Tutor: ${course.tutor}'),
            ],
          ),
        ),
      ),
    );
  }
}
