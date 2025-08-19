class AppUser {
  final String id;
  final String email;
  final String role; // business | client | designer
  final String name;

  AppUser({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
  });

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
    id: m['id'],
    email: m['email'],
    role: m['role'],
    name: m['name'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'role': role,
    'name': name,
  };
}

