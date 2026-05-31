class UserRequestBody {
  final String email;
  final String password;

  UserRequestBody({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password};
  }
}
