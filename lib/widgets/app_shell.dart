import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/routes/app_routes.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.title, required this.body});

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: moodleWhite,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: moodlePurple),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Moodle',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 8),
                  Text('Student portal',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text('Dashboard'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard),
            ),
            ListTile(
              leading: const Icon(Icons.school_outlined),
              title: const Text('My courses'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.courses),
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Calendar'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.calendar),
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notifications'),
              onTap: () => Navigator.pushReplacementNamed(
                  context, AppRoutes.notifications),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.profile),
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
