import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/views/dashboard_view.dart';

void main() {
  testWidgets('dashboard view renders the main summary sections',
      (tester) async {
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
}
