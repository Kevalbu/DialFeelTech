import 'dart:convert';

GetEmptyDataModel getEmptyDataModelFromJson(String str) =>
    GetEmptyDataModel.fromJson(json.decode(str));

String getEmptyDataModelToJson(GetEmptyDataModel data) =>
    json.encode(data.toJson());

class GetEmptyDataModel {
  final bool? status;
  final String? message;
  final List<dynamic>? data;

  GetEmptyDataModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetEmptyDataModel.fromJson(Map<String, dynamic> json) =>
      GetEmptyDataModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
      };
}
