class SignInResponseDto {
  final String accessToken;

  SignInResponseDto({required this.accessToken});

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) {
    return SignInResponseDto(
      accessToken: json['accessToken'],
    );
  }
}
