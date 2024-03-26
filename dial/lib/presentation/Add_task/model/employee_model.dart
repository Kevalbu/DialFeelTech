// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeModel> employeeModelFromJson(String str) =>
    List<EmployeeModel>.from(
        json.decode(str).map((x) => EmployeeModel.fromJson(x)));

String employeeModelToJson(List<EmployeeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeModel {
  final String? value;
  final String? label;
  final String? designation;
  final String? employeeId;
  final String? profilePicture;

  EmployeeModel({
    this.value,
    this.label,
    this.designation,
    this.employeeId,
    this.profilePicture,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        value: json["value"],
        label: json["label"],
        designation: json["designation"],
        employeeId: json["employeeId"],
        profilePicture: json["profilePicture"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "designation": designation,
        "employeeId": employeeId,
        "profilePicture": profilePicture,
      };
}
