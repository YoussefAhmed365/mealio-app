// Sign Up
class SignupCridentials {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool agreeToTerms;

  SignupCridentials({required this.firstName, required this.lastName, required this.email, required this.password, required this.agreeToTerms});

  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': password};
  }
}

// Sign In
class SigninCridentials {
  final String email;
  final String password;

  SigninCridentials({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
