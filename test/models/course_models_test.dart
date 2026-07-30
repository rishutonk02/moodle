import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/course.dart';

void main() {
  test('course model preserves nested topics and assignments', () {
    final course = Course(
      id: 'cmp5002',
      code: 'CMP5002',
      title: 'Cloud Computing',
      tutor: 'Dr. A. Tutor',
      summary: 'An introduction to cloud systems.',
      progress: 0.75,
      topics: const [
        CourseTopic(
          title: 'Week 1',
          description: 'Foundations',
          items: ['Overview', 'Setup'],
        ),
      ],
      assignments: [
        Assignment(
          id: 'brief',
          courseId: 'cmp5002',
          title: 'Coursework brief',
          description: 'Read and submit the plan.',
          points: 20,
          dueDate: DateTime(2026, 8, 14),
        ),
      ],
    );

    expect(course.code, 'CMP5002');
    expect(course.topics.single.items, ['Overview', 'Setup']);
    expect(course.assignments.single.points, 20);
    expect(course.assignments.single.dueDate.month, 8);
  });
}
