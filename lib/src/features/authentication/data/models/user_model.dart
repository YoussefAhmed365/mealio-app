import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.firstname,
    required super.lastname,
    super.displayName,
    super.photoUrl,
  });

  // تحويل من JSON (مثلاً من Firebase) إلى كائن
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
    );
  }

  // تحويل من كائن إلى JSON (لإرساله للسيرفر)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }

  // دالة تحويل مساعدة لإنشاء Model من Entity إذا لزم الأمر
  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      firstname: user.firstname,
      lastname: user.lastname,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
    );
  }
}