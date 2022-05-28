class Password {
  final int id;
  final String name;
  final String password;

  Password({
    required this.id,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(
      id: map["id"],
      name: map["name"],
      password: map["password"],
    );
  }

  @override
  String toString() => 'Password(id: $id, name: $name, password: $password)';

  Password copyWith({
    int? id,
    String? name,
    String? password,
  }) {
    return Password(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }
}
