import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.email,
    required super.id,
    required super.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toJason(UserModel? user) {
    if (user != null) {
      return {"id": user.id, "name": user.name, "email": user.email};
    }
    return {"id": id, "name": name, "email": email};
  }

  UserModel copyWith({String? newname, String? newemail}) {
    return UserModel(email: newemail ?? email, id: id, name: newname ?? name);
  }
}
