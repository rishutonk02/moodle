import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/main.dart';
import 'package:moodle/models/submission.dart';
import 'package:moodle/services/course_service.dart';
import 'package:moodle/services/search_service.dart';

void main() {
  testWidgets('drawer navigation opens the dynamic courses screen',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MoodleApp(initialRoute: '/'));

    expect(find.text('Dashboard'), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My courses'));
    await tester.pumpAndSettle();

    expect(find.text('Search, filter and open course content dynamically.'),
        findsOneWidget);
    expect(find.text('Mobile Application Development'), findsOneWidget);
  });

  testWidgets('courses screen filters results from the search box',
      (tester) async {
    await tester.pumpWidget(const MoodleApp(initialRoute: '/'));
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My courses'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'database');
    await tester.pumpAndSettle();

    expect(find.text('Databases and Cloud Data'), findsOneWidget);
    expect(find.text('Mobile Application Development'), findsNothing);
  });

  test('course service exposes dynamic coursework deadline', () {
    final events = CourseService().getCalendarEvents();

    expect(
      events.any(
          (event) => event.id == 'brief-deadline' && event.date.year == 2026),
      isTrue,
    );
  });

  test('global search returns assignments and resources', () async {
    final firebaseResults = await SearchService().search('firebase');
    final firestoreResults = await SearchService().search('firestore');

    expect(firebaseResults.map((result) => result.title),
        contains('Firebase setup evidence'));
    expect(firestoreResults.map((result) => result.title),
        contains('Firestore data model'));
    expect(firestoreResults.map((result) => result.title),
        contains('Firestore indexing guide'));
  });

  test('assignment submission serializes local state', () {
    final submittedAt = DateTime(2026, 8, 14, 16);
    final submission = AssignmentSubmission(
      assignmentId: 'moodle-coursework',
      userId: 'student',
      text: 'Completed repository submitted.',
      attachmentName: 'report.pdf',
      submittedAt: submittedAt,
    );

    final restored = AssignmentSubmission.fromJson(submission.toJson());

    expect(restored.assignmentId, 'moodle-coursework');
    expect(restored.hasAttachment, isTrue);
    expect(restored.submittedAt, submittedAt);
  });
}
