import 'package:google_sign_in/google_sign_in.dart';
import 'package:moodle/models/user_profile.dart';

class AuthService {
  String currentUserId() => 'student';

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    try {
      final account = await googleSignIn.signIn();
      return account;
    } catch (_) {
      return null;
    }
  }

  AppUserProfile getFallbackProfile() {
    return const AppUserProfile(
      name: 'Rishu Tonk',
      email: 'rishu@example.com',
      photoUrl: null,
    );
  }

  Stream<AppUserProfile?> authStateChanges() async* {
    yield getFallbackProfile();
  }

  Future<void> signOut() async {}
}
