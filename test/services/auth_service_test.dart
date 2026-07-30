import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/services/auth_service.dart';

void main() {
  test('auth service exposes the student user id', () {
    expect(AuthService().currentUserId(), 'local-student');
  });

  test('auth service returns the fallback profile', () {
    final profile = AuthService().getFallbackProfile();

    expect(profile.name, 'Rishu Tonk');
    expect(profile.email, 'up2286527@myport.ac.uk');
    expect(profile.photoUrl, isNull);
  });
}
