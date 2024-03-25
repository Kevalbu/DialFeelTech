// To parse this JSON data, do
//
//     final dispositionModel = dispositionModelFromJson(jsonString);

import 'dart:convert';

List<DispositionModel> dispositionModelFromJson(String str) =>
    List<DispositionModel>.from(
        json.decode(str).map((x) => DispositionModel.fromJson(x)));

String dispositionModelToJson(List<DispositionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DispositionModel {
  final String? id;
  final String? name;
  final String? description;
  final String? color;
  final String? createdBy;
  final DateTime? createdDate;
  final dynamic updatedBy;
  final dynamic updatedDate;

  DispositionModel({
    this.id,
    this.name,
    this.description,
    this.color,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory DispositionModel.fromJson(Map<String, dynamic> json) =>
      DispositionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        color: json["color"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        updatedBy: json["updatedBy"],
        updatedDate: json["updatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "color": color,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedDate": updatedDate,
      };
}
