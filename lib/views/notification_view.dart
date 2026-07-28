import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/services/notification_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Notifications',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Notifications',
            subtitle: 'Unread Moodle alerts, reminders and course messages.',
            icon: Icons.notifications_none_outlined,
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<Announcement>>(
            future: NotificationService().getAnnouncements(),
            builder: (context, snapshot) {
              final notifications = snapshot.data ?? const [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final unread = notifications.where((item) => !item.isRead).length;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionCard(
                    child: Text(
                      '$unread unread notification${unread == 1 ? '' : 's'}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...notifications.map(
                    (notification) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SectionCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            notification.isRead
                                ? Icons.notifications_none_outlined
                                : Icons.notifications_active_outlined,
                            color: notification.isRead
                                ? moodleTextMuted
                                : moodlePurple,
                          ),
                          title: Text(notification.title),
                          subtitle: Text(notification.message),
                          trailing: notification.isRead
                              ? const Chip(label: Text('Read'))
                              : const Chip(label: Text('New')),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
