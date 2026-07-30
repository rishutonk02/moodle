import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moodle/routes/app_routes.dart';
import 'package:moodle/services/firebase_service.dart';
import 'package:moodle/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseReady = await FirebaseService.initialise();
  final hasAuthenticatedUser =
      firebaseReady && FirebaseAuth.instance.currentUser != null;

  runApp(
    MoodleApp(
      initialRoute:
          hasAuthenticatedUser ? AppRoutes.dashboard : AppRoutes.login,
    ),
  );
}

class MoodleApp extends StatelessWidget {
  const MoodleApp({
    super.key,
    required this.initialRoute,
  });

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodle',
      theme: AppTheme.light(),
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
