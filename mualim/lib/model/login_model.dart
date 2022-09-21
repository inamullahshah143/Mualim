
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

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
        required this.deletedAt,
        required this.subjectId,
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
    dynamic deletedAt;
    int subjectId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        gender: json["gender"],
        organization: json["organization"],
        designation: json["designation"],
        phone: json["phone"],
        email: json["email"],
        qualification: json["qualification"],
        experience: json["experience"],
        cnic: json["cnic"],
        action: json["action"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        subjectId: json["subject_id"],
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
        "deleted_at": deletedAt,
        "subject_id": subjectId,
    };
}
