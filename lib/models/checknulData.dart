// To parse this JSON data, do
//
//     final checkNullData = checkNullDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class CheckNullData {
  CheckNullData({
    required this.sectionContent,
  });

  final List<dynamic> sectionContent;

  CheckNullData copyWith({
    required List<dynamic> sectionContent,
  }) =>
      CheckNullData(
        sectionContent: sectionContent,
      );

  factory CheckNullData.fromRawJson(String str) =>
      CheckNullData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckNullData.fromJson(json) => CheckNullData(
        sectionContent:
            List<dynamic>.from(json[0]["SectionContent"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "SectionContent": sectionContent == null
            ? null
            : List<dynamic>.from(sectionContent.map((x) => x)),
      };
}
