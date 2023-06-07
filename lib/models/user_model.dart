class User {
  String? id;
  String name;
  String email;
  String password;
  String birthday;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthday,
  });
}
