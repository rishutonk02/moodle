import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodle/models/submission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmissionService {
  SubmissionService({FirebaseFirestore? firestore}) : _firestore = firestore;

  final FirebaseFirestore? _firestore;

  Future<void> saveSubmission(AssignmentSubmission submission) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key(submission.assignmentId, submission.userId),
      jsonEncode(submission.toJson()),
    );

    try {
      final firestore = _firestore ?? FirebaseFirestore.instance;
      await firestore.collection('submitted_assignments').add(
            submission.toJson(),
          );
    } catch (_) {
      // Local submission state is the required fallback for unconfigured Firebase.
    }
  }

  Future<AssignmentSubmission?> getSubmission({
    required String assignmentId,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(assignmentId, userId));
    if (raw == null) {
      return null;
    }
    return AssignmentSubmission.fromJson(
      jsonDecode(raw) as Map<String, Object?>,
    );
  }

  static String _key(String assignmentId, String userId) {
    return 'submission:$userId:$assignmentId';
  }
}
