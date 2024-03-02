// To parse this JSON data, do
//
//     final listGetModel = listGetModelFromJson(jsonString);

import 'dart:convert';

List<ListGetModel> listGetModelFromJson(String str) => List<ListGetModel>.from(
    json.decode(str).map((x) => ListGetModel.fromJson(x)));

String listGetModelToJson(List<ListGetModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListGetModel {
  final String? value;
  final String? label;

  ListGetModel({
    this.value,
    this.label,
  });

  factory ListGetModel.fromJson(Map<String, dynamic> json) => ListGetModel(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
