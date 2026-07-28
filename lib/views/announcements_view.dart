import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/announcement.dart';
import 'package:moodle/services/notification_service.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class AnnouncementsView extends StatelessWidget {
  const AnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Announcements',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Announcements',
            subtitle: 'Course and site-wide Moodle updates from tutors.',
            icon: Icons.campaign_outlined,
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<Announcement>>(
            future: NotificationService().getAnnouncements(),
            builder: (context, snapshot) {
              final announcements = snapshot.data ?? const [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: announcements
                    .map(
                      (announcement) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SectionCard(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const CircleAvatar(
                              backgroundColor: moodleGrayBg,
                              child: Icon(
                                Icons.campaign_outlined,
                                color: moodlePurple,
                              ),
                            ),
                            title: Text(announcement.title),
                            subtitle: Text(announcement.message),
                            trailing: Text(announcement.courseCode),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
