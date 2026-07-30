import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService._();

  static Future<bool> initialise() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
