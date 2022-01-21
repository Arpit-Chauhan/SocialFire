class User {
  final String username;
  final String email;
  final String uid;
  final String photoUrl;
  final String bio;
  final List following;
  final List followers;

  User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following,
      };
}
