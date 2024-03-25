// To parse this JSON data, do
//
//     final singleContactModel = singleContactModelFromJson(jsonString);

import 'dart:convert';

SingleContactModel singleContactModelFromJson(String str) =>
    SingleContactModel.fromJson(json.decode(str));

String singleContactModelToJson(SingleContactModel data) =>
    json.encode(data.toJson());

class SingleContactModel {
  final String? id;
  final String? mobile1;
  final String? mobile2;
  final String? listId;
  final String? districtId;
  final String? district;
  final Disposition? disposition;
  final double? dealValue;
  final int? leadScore;
  final String? areaId;
  final String? area;
  final String? list;
  final String? name;
  final String? email;
  final String? company;
  final String? address;
  final String? note;
  final String? extra;
  final String? remarks;
  final String? qualification;
  final List<dynamic>? products;
  final bool? called;
  final bool? smsSent;
  final bool? emailSent;
  final bool? linkSent;
  final bool? appSent;
  final bool? lock;
  final bool? dnc;
  final bool? callBack;
  final DateTime? callbackOn;
  final dynamic callRecord;
  final dynamic calledById;
  final String? createdBy;
  final DateTime? createdDate;

  SingleContactModel({
    this.id,
    this.mobile1,
    this.mobile2,
    this.listId,
    this.districtId,
    this.district,
    this.disposition,
    this.dealValue,
    this.leadScore,
    this.areaId,
    this.area,
    this.list,
    this.name,
    this.email,
    this.company,
    this.address,
    this.note,
    this.extra,
    this.remarks,
    this.qualification,
    this.products,
    this.called,
    this.smsSent,
    this.emailSent,
    this.linkSent,
    this.appSent,
    this.lock,
    this.dnc,
    this.callBack,
    this.callbackOn,
    this.callRecord,
    this.calledById,
    this.createdBy,
    this.createdDate,
  });

  factory SingleContactModel.fromJson(Map<String, dynamic> json) =>
      SingleContactModel(
        id: json["id"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
        listId: json["listId"],
        districtId: json["districtId"],
        district: json["district"],
        disposition: json["disposition"] == null
            ? null
            : Disposition.fromJson(json["disposition"]),
        dealValue: json["dealValue"],
        leadScore: json["leadScore"],
        areaId: json["areaId"],
        area: json["area"],
        list: json["list"],
        name: json["name"],
        email: json["email"],
        company: json["company"],
        address: json["address"],
        note: json["note"],
        extra: json["extra"],
        remarks: json["remarks"],
        qualification: json["qualification"],
        products: json["products"] == null
            ? []
            : List<dynamic>.from(json["products"]!.map((x) => x)),
        called: json["called"],
        smsSent: json["smsSent"],
        emailSent: json["emailSent"],
        linkSent: json["linkSent"],
        appSent: json["appSent"],
        lock: json["lock"],
        dnc: json["dnc"],
        callBack: json["callBack"],
        callbackOn: json["callbackOn"] == null
            ? null
            : DateTime.parse(json["callbackOn"]),
        callRecord: json["callRecord"],
        calledById: json["calledById"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile1": mobile1,
        "mobile2": mobile2,
        "listId": listId,
        "districtId": districtId,
        "district": district,
        "disposition": disposition?.toJson(),
        "dealValue": dealValue,
        "leadScore": leadScore,
        "areaId": areaId,
        "area": area,
        "list": list,
        "name": name,
        "email": email,
        "company": company,
        "address": address,
        "note": note,
        "extra": extra,
        "remarks": remarks,
        "qualification": qualification,
        "products":
            products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
        "called": called,
        "smsSent": smsSent,
        "emailSent": emailSent,
        "linkSent": linkSent,
        "appSent": appSent,
        "lock": lock,
        "dnc": dnc,
        "callBack": callBack,
        "callbackOn": callbackOn?.toIso8601String(),
        "callRecord": callRecord,
        "calledById": calledById,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
      };
}

class Disposition {
  final String? id;
  final String? name;
  final String? color;

  Disposition({
    this.id,
    this.name,
    this.color,
  });

  factory Disposition.fromJson(Map<String, dynamic> json) => Disposition(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
      };
}
