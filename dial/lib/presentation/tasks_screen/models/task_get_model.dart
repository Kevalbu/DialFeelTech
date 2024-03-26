// To parse this JSON data, do
//
//     final getTaskModel = getTaskModelFromJson(jsonString);

import 'dart:convert';

GetTaskModel getTaskModelFromJson(String str) =>
    GetTaskModel.fromJson(json.decode(str));

String getTaskModelToJson(GetTaskModel data) => json.encode(data.toJson());

class GetTaskModel {
  final List<Datum>? data;
  final int? length;
  final int? doneTask;

  GetTaskModel({
    this.data,
    this.length,
    this.doneTask,
  });

  factory GetTaskModel.fromJson(Map<String, dynamic> json) => GetTaskModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        length: json["length"],
        doneTask: json["doneTask"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "length": length,
        "doneTask": doneTask,
      };
}

class Datum {
  final String? id;
  final String? title;
  final String? description;
  final String? contactId;
  final String? contact;
  final String? listId;
  final String? listName;
  final DateTime? remindOn;
  final String? accountName;
  final String? accountsId;
  final bool? isTaskDone;
  final String? createdBy;
  final DateTime? createdDate;
  final dynamic updatedBy;
  final dynamic updatedDate;

  Datum({
    this.id,
    this.title,
    this.description,
    this.contactId,
    this.contact,
    this.listId,
    this.listName,
    this.remindOn,
    this.accountName,
    this.accountsId,
    this.isTaskDone,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        contactId: json["contactId"],
        contact: json["contact"],
        listId: json["listId"],
        listName: json["listName"],
        remindOn:
            json["remindOn"] == null ? null : DateTime.parse(json["remindOn"]),
        accountName: json["accountName"],
        accountsId: json["accountsId"],
        isTaskDone: json["isTaskDone"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        updatedBy: json["updatedBy"],
        updatedDate: json["updatedDate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "contactId": contactId,
        "contact": contact,
        "listId": listId,
        "listName": listName,
        "remindOn": remindOn?.toIso8601String(),
        "accountName": accountName,
        "accountsId": accountsId,
        "isTaskDone": isTaskDone,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedDate": updatedDate,
      };
}
