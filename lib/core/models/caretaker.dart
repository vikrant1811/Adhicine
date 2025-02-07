class Caretaker {
  final String id;
  final String name;
  final String email;
  final String phone;

  Caretaker({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  static Caretaker fromMap(Map<String, dynamic> map, String id) {
    return Caretaker(
      id: id,
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}