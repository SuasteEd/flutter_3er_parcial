class UserModel {
  String? id;
  String name;
  String email;
  String password;
  String birthday;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthday,
  });
}
