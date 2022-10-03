// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.success,
    required this.token,
    required this.user,
  });

  String success;
  String token;
  User user;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.gender,
    required this.organization,
    required this.designation,
    required this.phone,
    required this.email,
    required this.qualification,
    required this.experience,
    required this.cnic,
    required this.action,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  String name;
  String gender;
  String organization;
  String designation;
  String phone;
  String email;
  String qualification;
  int experience;
  String cnic;
  String action;
  DateTime createdAt;
  DateTime updatedAt;
  String image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"].toString(),
        gender: json["gender"].toString(),
        organization: json["organization"].toString(),
        designation: json["designation"].toString(),
        phone: json["phone"].toString(),
        email: json["email"].toString(),
        qualification: json["qualification"].toString(),
        experience: json["experience"],
        cnic: json["cnic"].toString(),
        action: json["action"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "organization": organization,
        "designation": designation,
        "phone": phone,
        "email": email,
        "qualification": qualification,
        "experience": experience,
        "cnic": cnic,
        "action": action,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
      };
}
