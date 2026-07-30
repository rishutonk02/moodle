import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moodle/models/user_profile.dart';
import 'package:moodle/services/firebase_service.dart';
import 'package:moodle/utils/students_details.dart';

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  final FirebaseAuth? _auth;
  final FirebaseFirestore? _firestore;
  final GoogleSignIn? _googleSignIn;

  Stream<AppUserProfile?> authStateChanges() async* {
    final ready = await FirebaseService.initialise();
    if (!ready) {
      yield null;
      return;
    }

    final auth = _auth ?? FirebaseAuth.instance;
    yield* auth.authStateChanges().map(_profileFromUser);
  }

  Future<AppUserProfile?> signInWithGoogle() async {
    final ready = await FirebaseService.initialise();
    if (!ready) {
      return null;
    }

    final auth = _auth ?? FirebaseAuth.instance;
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      provider.addScope('email');
      provider.addScope('profile');
      final userCredential = await auth.signInWithPopup(provider);
      final profile = _profileFromUser(userCredential.user);
      if (profile != null) {
        await saveUserProfile(profile);
      }
      return profile;
    }

    final googleSignIn = _googleSignIn ?? GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential = await auth.signInWithCredential(credential);
    final profile = _profileFromUser(userCredential.user);
    if (profile != null) {
      await saveUserProfile(profile);
    }
    return profile;
  }

  Future<void> signOut() async {
    final ready = await FirebaseService.initialise();
    if (!ready) {
      return;
    }
    if (!kIsWeb) {
      await (_googleSignIn ?? GoogleSignIn()).signOut();
    }
    await (_auth ?? FirebaseAuth.instance).signOut();
  }

  String currentUserId() {
    final auth = _auth;
    if (auth != null) {
      return auth.currentUser?.uid ?? 'local-student';
    }

    if (Firebase.apps.isEmpty) {
      return 'local-student';
    }

    return FirebaseAuth.instance.currentUser?.uid ?? 'local-student';
  }

  Future<void> saveUserProfile(AppUserProfile profile) async {
    final firestore = _firestore ?? FirebaseFirestore.instance;
    await firestore.collection('users').doc(profile.uid).set(
          profile.toFirestore(),
          SetOptions(merge: true),
        );
  }

  AppUserProfile getFallbackProfile() {
    return const AppUserProfile(
      uid: 'local-student',
      name: StudentDetails.name,
      email: StudentDetails.email,
    );
  }

  AppUserProfile? _profileFromUser(User? user) {
    if (user == null) {
      return null;
    }
    return AppUserProfile(
      uid: user.uid,
      name: user.displayName?.trim().isNotEmpty == true
          ? user.displayName!
          : StudentDetails.name,
      email: user.email ?? StudentDetails.email,
      photoUrl: user.photoURL,
    );
  }
}
