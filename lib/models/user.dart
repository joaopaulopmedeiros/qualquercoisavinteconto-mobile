import 'package:qualquercoisavinteconto/models/role.dart';

class User {
  final int id;
  final String name;
  final String email;
  final List<Role> roles;

  User({required this.id, required this.name, required this.email, required this.roles});

  factory User.fromJson(Map<String, dynamic> json) {
    var rolesFromJson = json['roles'] as List;
    List<Role> roleList = rolesFromJson.map((role) => Role.fromJson(role)).toList();

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      roles: roleList,
    );
  }
}