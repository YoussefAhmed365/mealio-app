import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String firstname;
  final String lastname;
  final String? displayName;
  final String? photoUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.firstname,
    required this.lastname,
    this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, email, firstname, lastname, displayName, photoUrl];
}

// class User {
//   final String firstname;
//   final String lastname;
//   final String email;
//
//   User({required this.firstname, required this.lastname, required this.email});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(firstname: json['firstname'] as String, lastname: json['lastname'] as String, email: json['email'] as String);
//   }
// }