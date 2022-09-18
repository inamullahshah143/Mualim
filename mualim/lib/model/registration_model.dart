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
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.organization,
    required this.designation,
    required this.qualification,
    required this.experience,
    required this.cnic,
    required this.phone,
    required this.subjectId,
  });

  String name;
  String email;
  String password;
  String gender;
  String organization;
  String designation;
  String qualification;
  int experience;
  String cnic;
  String phone;
  int subjectId;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        organization: json["organization"],
        designation: json["designation"],
        qualification: json["qualification"],
        experience: json["experience"],
        cnic: json["cnic"],
        phone: json["phone"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "gender": gender,
        "organization": organization,
        "designation": designation,
        "qualification": qualification,
        "experience": experience,
        "cnic": cnic,
        "phone": phone,
        "subject_id": subjectId,
      };
}
