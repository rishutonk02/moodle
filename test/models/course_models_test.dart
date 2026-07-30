import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/course.dart';

void main() {
  group('Course Model', () {
    test('preserves nested topics, assignments, and resources', () {
      const topic = CourseTopic(
        title: 'Week 1',
        description: 'Foundations',
        items: ['Overview', 'Setup'],
      );

      const resource = ResourceItem(
        id: 'guide',
        courseId: 'cmp5002',
        title: 'Setup guide',
        type: ResourceType.file,
      );

      final assignment = Assignment(
        id: 'brief',
        courseId: 'cmp5002',
        title: 'Coursework brief',
        description: 'Read and submit the plan.',
        dueDate: DateTime(2026, 8, 14),
        status: AssignmentStatus.notStarted,
        points: 20,
      );

      final course = Course(
        id: 'cmp5002',
        code: 'CMP5002',
        title: 'Cloud Computing',
        summary: 'An introduction to cloud systems.',
        tutor: 'Dr. A. Tutor',
        progress: 0.75,
        category: 'Current',
        topics: const [topic],
        assignments: [assignment],
        resources: const [resource],
      );

      expect(course.id, equals('cmp5002'));
      expect(course.code, equals('CMP5002'));
      expect(course.title, equals('Cloud Computing'));
      expect(course.summary, contains('cloud'));
      expect(course.tutor, equals('Dr. A. Tutor'));
      expect(course.progress, equals(0.75));
      expect(course.category, equals('Current'));

      expect(course.topics, hasLength(1));
      expect(course.topics.first.title, equals('Week 1'));
      expect(course.topics.first.description, equals('Foundations'));
      expect(course.topics.first.items, equals(['Overview', 'Setup']));

      expect(course.assignments, hasLength(1));
      expect(course.assignments.first.id, equals('brief'));
      expect(course.assignments.first.courseId, equals('cmp5002'));
      expect(course.assignments.first.title, equals('Coursework brief'));
      expect(course.assignments.first.description,
          equals('Read and submit the plan.'));
      expect(course.assignments.first.dueDate, equals(DateTime(2026, 8, 14)));
      expect(
          course.assignments.first.status, equals(AssignmentStatus.notStarted));
      expect(course.assignments.first.points, equals(20));

      expect(course.resources, hasLength(1));
      expect(course.resources.first.id, equals('guide'));
      expect(course.resources.first.courseId, equals('cmp5002'));
      expect(course.resources.first.title, equals('Setup guide'));
      expect(course.resources.first.type, equals(ResourceType.file));
    });
  });
}
