class User {
  final String firstname;
  final String lastname;
  final String email;

  User({required this.firstname, required this.lastname, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(firstname: json['firstname'] as String, lastname: json['lastname'] as String, email: json['email'] as String);
  }
}
