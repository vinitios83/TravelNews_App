// To parse this JSON data, do
//
//     final tourismPpp = tourismPppFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class TourismPpp {
  TourismPpp({
    required this.tourismName,
  });

  final List<TourismName> tourismName;

  TourismPpp copyWith({
    required List<TourismName> tourismName,
  }) =>
      TourismPpp(
        tourismName: tourismName,
      );

  factory TourismPpp.fromRawJson(String str) =>
      TourismPpp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourismPpp.fromJson(json) => TourismPpp(
        tourismName: List<TourismName>.from(
            json[0]["TourismName"].map((x) => TourismName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TourismName": tourismName == null
            ? null
            : List<dynamic>.from(tourismName.map((x) => x.toJson())),
      };
}

class TourismName {
  TourismName({
    required this.state,
    required this.orgname,
    required this.sectionCate,
  });

  final String state;
  final String orgname;
  final List<SectionCate> sectionCate;

  TourismName copyWith({
    required String state,
    required String orgname,
    required List<SectionCate> sectionCate,
  }) =>
      TourismName(
        state: state,
        orgname: orgname,
        sectionCate: sectionCate,
      );

  factory TourismName.fromRawJson(String str) =>
      TourismName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TourismName.fromJson(Map<String, dynamic> json) => TourismName(
        state: json["State"],
        orgname: json["Orgname"],
        sectionCate: List<SectionCate>.from(
            json["SectionCate"].map((x) => SectionCate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "State": state,
        "Orgname": orgname,
        "SectionCate": List<dynamic>.from(sectionCate.map((x) => x.toJson())),
      };
}

class SectionCate {
  SectionCate({
    required this.categoryid,
    required this.category,
    required this.sectionSubCate,
  });

  final String categoryid;
  final String category;
  final List<SectionSubCate> sectionSubCate;

  SectionCate copyWith({
    required String categoryid,
    required String category,
    required List<SectionSubCate> sectionSubCate,
  }) =>
      SectionCate(
        categoryid: categoryid,
        category: category,
        sectionSubCate: sectionSubCate,
      );

  factory SectionCate.fromRawJson(String str) =>
      SectionCate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionCate.fromJson(Map<String, dynamic> json) => SectionCate(
        categoryid: json["categoryid"],
        category: json["category"],
        sectionSubCate: List<SectionSubCate>.from(
            json["SectionSubCate"].map((x) => SectionSubCate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categoryid": categoryid,
        "category": category,
        "SectionSubCate": sectionSubCate == null
            ? null
            : List<dynamic>.from(sectionSubCate.map((x) => x.toJson())),
      };
}

class SectionSubCate {
  SectionSubCate({
    required this.subcategoryid,
    required this.subcategory,
  });

  final String subcategoryid;
  final String subcategory;

  SectionSubCate copyWith({
    required String subcategoryid,
    required String subcategory,
  }) =>
      SectionSubCate(
        subcategoryid: subcategoryid,
        subcategory: subcategory,
      );

  factory SectionSubCate.fromRawJson(String str) =>
      SectionSubCate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionSubCate.fromJson(Map<String, dynamic> json) => SectionSubCate(
        subcategoryid:
            json["subcategoryid"],
        subcategory: json["subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "subcategoryid": subcategoryid,
        "subcategory": subcategory,
      };
}
