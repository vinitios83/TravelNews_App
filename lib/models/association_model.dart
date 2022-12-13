import 'dart:convert';

import '../services/helper.dart';



List<AssociationList> associationListFromJson(String str) =>
    List<AssociationList>.from(
        json.decode(str).map((x) => AssociationList.fromJson(x)));

String associationListToJson(List<AssociationList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssociationList {
  AssociationList({
    required this.association,
  });

  List<Association> association;

  factory AssociationList.fromJson(Map<String, dynamic> json) =>
      AssociationList(
        association: List<Association>.from(
            json["association"].map((x) => Association.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "association": List<dynamic>.from(association.map((x) => x.toJson())),
      };
}

class Association {
  Association({
    required this.name,
    required this.id,
    required this.atype,
    required this.imageUrl,
  });

  String name;
  String id;
  String atype;
  String imageUrl;

  factory Association.fromJson(Map<String, dynamic> json) => Association(
      name: json["name"],
      id: json["id"],
      atype: json["atype"],
      imageUrl:
          '${AssociationHelper.URL_LIST_OF_ASSOCIATION_LOGOS}${json["name"]}.jpg');

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "atype": atype,
      };
}
