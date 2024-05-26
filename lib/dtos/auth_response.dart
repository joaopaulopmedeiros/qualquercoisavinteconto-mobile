import 'package:qualquercoisavinteconto/models/user.dart';

class AuthResponseDto {
  final String accessToken;
  final User identity;

  AuthResponseDto({required this.accessToken, required this.identity});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      accessToken: json['accessToken'],
      identity: User.fromJson(json['identity']),
    );
  }
}
