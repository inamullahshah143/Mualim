

import 'dart:convert';

RegistrationModel registrationModelFromJson(String str) =>
    RegistrationModel.fromJson(json.decode(str));

String registrationModelToJson(RegistrationModel data) =>
    json.encode(data.toJson());

class RegistrationModel {
  RegistrationModel({
    required this.status,
    required this.success,
    required this.data,
    required this.token,
  });

  int status;
  String success;
  Data data;
  String token;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        status: json["status"],
        success: json["success"],
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  Data({
    required this.name,
    required this.gender,
    required this.organization,
    required this.designation,
    required this.qualification,
    required this.experience,
    required this.cnic,
    required this.phone,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  String gender;
  String organization;
  String designation;
  String qualification;
  String experience;
  String cnic;
  String phone;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        gender: json["gender"],
        organization: json["organization"],
        designation: json["designation"],
        qualification: json["qualification"],
        experience: json["experience"],
        cnic: json["cnic"],
        phone: json["phone"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "organization": organization,
        "designation": designation,
        "qualification": qualification,
        "experience": experience,
        "cnic": cnic,
        "phone": phone,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
