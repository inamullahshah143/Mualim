// To parse this JSON data, do
//
//     final registrationModel = registrationModelFromJson(jsonString);

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
    required this.instituion,
    required this.designation,
    required this.qualification,
    required this.experience,
    required this.cnic,
    required this.phone,
    required this.email,
    required this.province,
    required this.district,
    required this.subjectId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  String gender;
  dynamic instituion;
  String designation;
  String qualification;
  String experience;
  String cnic;
  String phone;
  String email;
  String province;
  String district;
  dynamic subjectId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        gender: json["gender"],
        instituion: json["instituion"],
        designation: json["designation"],
        qualification: json["qualification"],
        experience: json["experience"],
        cnic: json["cnic"],
        phone: json["phone"],
        email: json["email"],
        province: json["province"],
        district: json["district"],
        subjectId: json["subject_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "instituion": instituion,
        "designation": designation,
        "qualification": qualification,
        "experience": experience,
        "cnic": cnic,
        "phone": phone,
        "email": email,
        "province": province,
        "district": district,
        "subject_id": subjectId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
