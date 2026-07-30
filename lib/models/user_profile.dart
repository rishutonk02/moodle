class AppUserProfile {
  const AppUserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  final String uid;
  final String name;
  final String email;
  final String? photoUrl;

  Map<String, Object?> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory AppUserProfile.fromFirestore(Map<String, Object?> data) {
    return AppUserProfile(
      uid: data['uid'] as String? ?? '',
      name: data['name'] as String? ?? 'Student',
      email: data['email'] as String? ?? '',
      photoUrl: data['photoUrl'] as String?,
    );
  }

  get displayName => null;
}
