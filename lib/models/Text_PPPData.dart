// To parse this JSON data, do
//
//     final tourismPppData = tourismPppDataFromJson(jsonString);

import 'dart:convert';

class TextPppData {
  TextPppData({
    required this.sectionContent,
  });

  final List<SectionContent> sectionContent;

  TextPppData copyWith({
    required List<SectionContent> sectionContent,
  }) =>
      TextPppData(
        sectionContent: sectionContent,
      );

  factory TextPppData.fromRawJson(String str) =>
      TextPppData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TextPppData.fromJson(json) => TextPppData(
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
      );

  factory SectionContent.fromRawJson(String str) =>
      SectionContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SectionContent.fromJson(Map<String, dynamic> json) => SectionContent(
        ni: json["NI"],
        orgName: json["OrgName"],
        category: json["Category"],
        subCategory: json["subCategory"],
        sectiondetails:
            json["sectiondetails"],
        title: json["title"],
        img: json["img"],
        video: json["video"],
        uploadfile: json["uploadfile"],
        link: json["link"],
        createdate: json["createdate"],
        contenttype: json["contenttype"],
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
      };
}
