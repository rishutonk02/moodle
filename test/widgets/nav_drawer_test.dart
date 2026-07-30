import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/widgets/nav_drawer.dart';

void main() {
  testWidgets('nav drawer shows dashboard as selected on the dashboard route',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (_) => const Scaffold(
                appBar: AppBar(),
                drawer: NavDrawer(),
                body: Text('Home'),
              ),
          '/courses': (_) => const Scaffold(body: Text('Courses page')),
        },
        initialRoute: '/',
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    final dashboardTile =
        tester.widget<ListTile>(find.widgetWithText(ListTile, 'Dashboard'));
    expect(dashboardTile.selected, isTrue);
  });

  testWidgets('nav drawer navigates to courses when tapped', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/': (_) => const Scaffold(
                appBar: AppBar(),
                drawer: NavDrawer(),
                body: Text('Home'),
              ),
          '/courses': (_) => const Scaffold(body: Text('Courses page')),
        },
        initialRoute: '/',
      ),
    );

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My courses'));
    await tester.pumpAndSettle();

    expect(find.text('Courses page'), findsOneWidget);
  });
}
