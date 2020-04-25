class User {
  final String id;
  final String fullName;
  final String email;
  final String avatar;

  User({this.id, this.fullName, this.email, this.avatar});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        avatar = data['avatar'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'avatar': avatar,
    };
  }
}