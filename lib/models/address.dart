class Address {
  final int id;
  final String street;
  final String number;
  final String city;
  final String state;

  Address({
    required this.id,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? 0,
      street: json['street'] ?? '',
      number: json['number'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'street': street,
      'number': number,
      'city': city,
      'state': state,
    };
  }
}