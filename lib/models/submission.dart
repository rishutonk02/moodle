class AssignmentSubmission {
  const AssignmentSubmission({
    required this.assignmentId,
    required this.userId,
    required this.text,
    required this.attachmentName,
    required this.submittedAt,
  });

  final String assignmentId;
  final String userId;
  final String text;
  final String attachmentName;
  final DateTime submittedAt;

  bool get hasAttachment => attachmentName.isNotEmpty;

  Map<String, Object?> toJson() {
    return {
      'assignmentId': assignmentId,
      'userId': userId,
      'text': text,
      'attachmentName': attachmentName,
      'submittedAt': submittedAt.toIso8601String(),
    };
  }

  factory AssignmentSubmission.fromJson(Map<String, Object?> json) {
    return AssignmentSubmission(
      assignmentId: json['assignmentId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      text: json['text'] as String? ?? '',
      attachmentName: json['attachmentName'] as String? ?? '',
      submittedAt: DateTime.tryParse(json['submittedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
