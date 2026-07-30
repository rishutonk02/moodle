import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/views/dashboard_view.dart';

void main() {
  test('dashboard route falls back to the dashboard view', () {
    final route = AppRoutes.onGenerateRoute(
      const RouteSettings(name: AppRoutes.dashboard),
    );

    expect(route, isA<MaterialPageRoute<dynamic>>());
    expect(route.settings.name, AppRoutes.dashboard);
  });

  test('unknown routes still resolve to the dashboard view', () {
    final route = AppRoutes.onGenerateRoute(
      const RouteSettings(name: '/unknown'),
    );

    expect(route, isA<MaterialPageRoute<dynamic>>());
    expect(route.settings.name, '/unknown');
  });

  testWidgets('dashboard route builds the dashboard screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.dashboard,
      ),
    );

    expect(find.byType(DashboardView), findsOneWidget);
    expect(find.text('Dashboard'), findsWidgets);
  });
}
