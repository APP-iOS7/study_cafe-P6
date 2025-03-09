class UserModel {
  final String username;
  final String useremail;
  final String uid;
  final String? profileImage;

  UserModel({
    required this.username,
    required this.useremail,
    required this.uid,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'useremail': useremail,
      'uid': uid,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      useremail: json['useremail'],
      uid: json['uid'],
      profileImage: json['profileImage'],
    );
  }
}
