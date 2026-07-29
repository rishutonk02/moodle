import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<bool> initialise() async {
    try {
      await Firebase.initializeApp();
      return true;
    } catch (_) {
      return false;
    }
  }
}
