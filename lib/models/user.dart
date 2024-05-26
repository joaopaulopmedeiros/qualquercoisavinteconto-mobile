import 'dart:ffi';

class User {
  final Long id;
  final String name;
  final String email;
  final String password;  

  User({required this.id, required this.name, required this.email, required this.password});  
}