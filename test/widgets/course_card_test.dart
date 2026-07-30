import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/course.dart';
import 'package:moodle/widgets/course_card.dart';

void main() {
  testWidgets('course card renders the course summary information',
      (tester) async {
    const course = Course(
      id: 'cmp5002',
      code: 'CMP5002',
      title: 'Cloud Computing',
      tutor: 'Dr. A. Tutor',
      summary: 'An introduction to cloud systems.',
      progress: 0.75,
      topics: [],
      assignments: [],
      category: '',
      resources: [],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CourseCard(course: course),
        ),
      ),
    );

    expect(find.text('CMP5002'), findsOneWidget);
    expect(find.text('Cloud Computing'), findsOneWidget);
    expect(find.text('An introduction to cloud systems.'), findsOneWidget);
    expect(find.text('Tutor: Dr. A. Tutor'), findsOneWidget);
  });
}
