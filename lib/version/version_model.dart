import 'dart:convert';

VersionModel versionModelFromJson(String str) =>
    VersionModel.fromJson(json.decode(str));

String versionModelToJson(VersionModel data) => json.encode(data.toJson());

class VersionModel {
  VersionModel({
    required this.latestversion,
    required this.message,
    required this.package,
    required this.isforced,
    required this.maintenance,
    required this.youtubekey,
    required this.youtubedefault,
  });

  final String latestversion;
  final String message;
  final String package;
  final String isforced;
  final String maintenance;
  final String youtubekey;
  final String youtubedefault;

  factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        latestversion: json["latestversion"],
        message: json["message"],
        package: json["package"],
        isforced: json["isforced"],
        maintenance: json["maintenance"],
        youtubekey: json["youtubekey"],
        youtubedefault: json["youtubedefault"],
      );

  Map<String, dynamic> toJson() => {
        "latestversion": latestversion,
        "message": message,
        "package": package,
        "isforced": isforced,
        "maintenance": maintenance,
        "youtubekey": youtubekey,
        "youtubedefault": youtubedefault,
      };
}
