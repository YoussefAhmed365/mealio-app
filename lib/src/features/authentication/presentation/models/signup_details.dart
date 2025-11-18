class SignupDetails {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool agreeToTerms;

  SignupDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.agreeToTerms,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}