import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/views/dashboard_view.dart';

void main() {
  testWidgets('dashboard view renders the main summary sections',
      (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: DashboardView(),
      ),
    );

    expect(find.text('Recently accessed courses'), findsOneWidget);
    expect(find.text('Upcoming deadlines'), findsOneWidget);
    expect(find.text('Latest announcements'), findsOneWidget);
    expect(find.text('UP number: 2286527'), findsOneWidget);
  });

  testWidgets('dashboard metric cards navigate to their sections',
      (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.dashboard,
      ),
    );

    await tester.tap(find.text('Active courses'));
    await tester.pumpAndSettle();
    expect(find.text('Search, filter and open course content dynamically.'),
        findsOneWidget);
  });

  testWidgets('dashboard assessments card opens assessments', (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.dashboard,
      ),
    );

    await tester.tap(find.text('Assessments'));
    await tester.pumpAndSettle();

    expect(find.text('Review due dates, grades and submission status.'),
        findsOneWidget);
  });

  testWidgets('dashboard unread notices card opens notifications',
      (tester) async {
    tester.view.physicalSize = const Size(1400, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.dashboard,
      ),
    );

    await tester.tap(find.text('Unread notices'));
    await tester.pumpAndSettle();

    expect(find.text('Unread Moodle alerts, reminders and course messages.'),
        findsOneWidget);
  });
}
