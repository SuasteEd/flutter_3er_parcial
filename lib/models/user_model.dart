class UserModel {
  String? id;
  String name;
  String lastName;
  String email;
  String password;
  String birthday;

  UserModel({
    this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.birthday,
  });
}
