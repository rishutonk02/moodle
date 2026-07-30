import 'package:flutter_test/flutter_test.dart';
import 'package:moodle/services/auth_service.dart';

void main() {
  test('auth service exposes the student user id', () {
    expect(AuthService().currentUserId(), 'student');
  });

  test('auth service returns the fallback profile', () {
    final profile = AuthService().getFallbackProfile();

    expect(profile.name, 'Rishu Tonk');
    expect(profile.email, 'rishu@example.com');
    expect(profile.photoUrl, isNull);
  });
}
