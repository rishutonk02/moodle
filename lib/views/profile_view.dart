import 'package:flutter/material.dart';
import 'package:moodle/constants.dart';
import 'package:moodle/models/user_profile.dart';
import 'package:moodle/services/auth_service.dart';
import 'package:moodle/utils/student_details.dart';
import 'package:moodle/widgets/app_shell.dart';
import 'package:moodle/widgets/responsive_page.dart';
import 'package:moodle/widgets/section_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final fallback = AuthService().getFallbackProfile();

    return AppShell(
      title: 'Profile',
      body: ResponsivePage(
        children: [
          const PageHeader(
            title: 'Profile',
            subtitle: 'Student identity and Firebase authentication status.',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          SectionCard(
            child: StreamBuilder<AppUserProfile?>(
              stream: AuthService().authStateChanges(),
              builder: (context, snapshot) {
                final profile = snapshot.data ?? fallback;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final avatar = CircleAvatar(
                      radius: 42,
                      backgroundColor: moodlePurple,
                      backgroundImage: profile.photoUrl == null
                          ? null
                          : NetworkImage(profile.photoUrl!),
                      child: profile.photoUrl == null
                          ? const Text(
                              StudentDetails.initials,
                              style: TextStyle(
                                color: moodleWhite,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    );
                    final details = Column(
                      crossAxisAlignment: constraints.maxWidth > 560
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Text(
                          profile.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(profile.email),
                        const SizedBox(height: 4),
                        const Text('UP number: ${StudentDetails.upNumber}'),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: () async {
                            await AuthService().signOut();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                (_) => false,
                              );
                            }
                          },
                          icon: const Icon(Icons.logout_outlined),
                          label: const Text('Sign out'),
                        ),
                      ],
                    );
                    if (constraints.maxWidth <= 560) {
                      return Column(
                        children: [avatar, const SizedBox(height: 16), details],
                      );
                    }
                    return Row(
                      children: [
                        avatar,
                        const SizedBox(width: 18),
                        Expanded(child: details),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
