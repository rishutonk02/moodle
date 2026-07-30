import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/models/user_profile.dart';

void main() {
  test('user profile stores uid name email and photo url', () {
    const profile = AppUserProfile(
      uid: 'student-1',
      name: 'Rishu Tonk',
      email: 'up2286527@myport.ac.uk',
      photoUrl: 'https://example.com/avatar.png',
    );

    expect(profile.uid, 'student-1');
    expect(profile.name, 'Rishu Tonk');
    expect(profile.email, 'up2286527@myport.ac.uk');
    expect(profile.photoUrl, 'https://example.com/avatar.png');
  });

  test('user profile allows a missing photo url', () {
    const profile = AppUserProfile(
      uid: 'student-1',
      name: 'Rishu Tonk',
      email: 'up2286527@myport.ac.uk',
      photoUrl: null,
    );

    expect(profile.photoUrl, isNull);
  });

  test('user profile round trips through firestore maps', () {
    const profile = AppUserProfile(
      uid: 'student-1',
      name: 'Rishu Tonk',
      email: 'up2286527@myport.ac.uk',
      photoUrl: 'https://example.com/avatar.png',
    );

    final firestoreData = profile.toFirestore();
    final restored = AppUserProfile.fromFirestore(firestoreData);

    expect(restored.uid, 'student-1');
    expect(restored.name, 'Rishu Tonk');
    expect(restored.email, 'up2286527@myport.ac.uk');
    expect(restored.photoUrl, 'https://example.com/avatar.png');
  });
}
