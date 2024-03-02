// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? message;
  final String? accessToken;
  final UserData? userData;

  LoginModel({
    this.message,
    this.accessToken,
    this.userData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        accessToken: json["accessToken"],
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "userData": userData?.toJson(),
      };
}

class UserData {
  final String? email;
  final String? userName;
  final dynamic employeeCode;
  final String? profilePic;
  final String? roleName;
  final String? roleId;
  final dynamic employeeId;
  final bool? isPasswordSet;
  final bool? isMultiProfile;

  UserData({
    this.email,
    this.userName,
    this.employeeCode,
    this.profilePic,
    this.roleName,
    this.roleId,
    this.employeeId,
    this.isPasswordSet,
    this.isMultiProfile,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        email: json["email"],
        userName: json["userName"],
        employeeCode: json["employeeCode"],
        profilePic: json["profilePic"],
        roleName: json["roleName"],
        roleId: json["roleId"],
        employeeId: json["employeeId"],
        isPasswordSet: json["isPasswordSet"],
        isMultiProfile: json["isMultiProfile"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "employeeCode": employeeCode,
        "profilePic": profilePic,
        "roleName": roleName,
        "roleId": roleId,
        "employeeId": employeeId,
        "isPasswordSet": isPasswordSet,
        "isMultiProfile": isMultiProfile,
      };
}
