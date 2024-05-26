import 'package:qualquercoisavinteconto/models/user.dart';

class SignInResponseDto {
  final String accessToken;
  final User identity;

  SignInResponseDto({required this.accessToken, required this.identity});

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) {
    return SignInResponseDto(
      accessToken: json['accessToken'],
      identity: User.fromJson(json['identity']),
    );
  }
}
