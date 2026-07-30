import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/user_profile.dart';

void main() {
  test('user profile stores name email and photo url', () {
    const profile = AppUserProfile(
      name: 'Rishu Tonk',
      email: 'rishu@example.com',
      photoUrl: 'https://example.com/avatar.png',
    );

    expect(profile.name, 'Rishu Tonk');
    expect(profile.email, 'rishu@example.com');
    expect(profile.photoUrl, 'https://example.com/avatar.png');
  });

  test('user profile allows a missing photo url', () {
    const profile = AppUserProfile(
      name: 'Rishu Tonk',
      email: 'rishu@example.com',
      photoUrl: null,
    );

    expect(profile.photoUrl, isNull);
  });
}
