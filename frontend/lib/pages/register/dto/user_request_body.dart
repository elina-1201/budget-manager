class UserRequestBody {
  final String name;
  final String email;
  final String password;

  UserRequestBody({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {'name': name.trim(), 'email': email.trim(), 'password': password};
  }
}
