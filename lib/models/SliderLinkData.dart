// To parse this JSON data, do
//
//     final imgData = imgDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class SliderData {
  SliderData({
    required this.sectionContent,
  });

  final List<SectionContent> sectionContent;

  SliderData copyWith({
    required List<SectionContent> sectionContent,
  }) =>
      SliderData(
        sectionContent: sectionContent,
      );

  factory SliderData.fromRawJson(String str) =>
      SliderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SliderData.fromJson(json) => SliderData(
        sectionContent: List<SectionContent>.from(
            json[0]["SectionContent"].map((x) => SectionContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SectionContent": sectionContent == null
            ? null
            : List<dynamic>.from(sectionContent.map((x) => x.toJson())),
      };
}

class SectionContent {
  SectionContent({
    required this.ni,
    required this.orgName,
    required this.category,
    required this.subCategory,
    required this.sectiondetails,
    required this.title,
    required this.img,
    required this.video,
    required this.uploadfile,
    required this.link,
    required this.createdate,
    required this.contenttype,
    required this.items,
  });

  final String ni;
  final String orgName;
  final String category;
  final String subCategory;
  final String sectiondetails;
  final String title;
  final String img;
  final String video;
  final String uploadfile;
  final String link;
  final String createdate;
  final String contenttype;
  final List<Map> items;

  SectionContent copyWith({
    required String ni,
    required String orgName,
    required String category,
    required String subCategory,
    required String sectiondetails,
    required String title,
    required String img,
    required String video,
    required String uploadfile,
    required String link,
    required String createdate,
    required String contenttype,
    required List<Map> items,
  }) =>
      SectionContent(
        ni: ni,
        orgName: orgName,
        category: category,
        subCategory: subCategory,
        sectiondetails: sectiondetails,
        title: title,
        img: img,
        video: video,
        uploadfile: uploadfile,
        link: link,
        createdate: createdate,
        contenttype: contenttype,
        items: items,
      );

  factory SectionContent.fromRawJson(String str) =>
      SectionContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionContent.fromJson(Map<String, dynamic> json) => SectionContent(
        ni: json["NI"] ?? null,
        orgName: json["OrgName"] ?? null,
        category: json["Category"] ?? null,
        subCategory: json["subCategory"] ?? null,
        sectiondetails: json["sectiondetails"] ?? null,
        title: json["title"] ?? null,
        img: json["img"] ?? null,
        video: json["video"] ?? null,
        uploadfile: json["uploadfile"] ?? null,
        link: json["link"] ?? null,
        createdate: json["createdate"] ?? null,
        contenttype: json["contenttype"] ?? null,
        items: List<Map>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "NI": ni,
        "OrgName": orgName,
        "Category": category,
        "subCategory": subCategory,
        "sectiondetails": sectiondetails,
        "title": title,
        "img": img,
        "video": video,
        "uploadfile": uploadfile,
        "link": link,
        "createdate": createdate,
        "contenttype": contenttype,
        "items": items == null ? null : List<dynamic>.from(items.map((x) => x)),
      };
}
