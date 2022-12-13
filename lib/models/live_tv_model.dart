import 'dart:convert';

LiveTvModel liveTvModelFromJson(String str) =>
    LiveTvModel.fromJson(json.decode(str));

String liveTvModelToJson(LiveTvModel data) => json.encode(data.toJson());

class LiveTvModel {
  LiveTvModel({
    required this.livetvurl,
  });

  final String livetvurl;

  factory LiveTvModel.fromJson(Map<String, dynamic> json) => LiveTvModel(
        livetvurl: json["livetvurl"],
      );

  Map<String, dynamic> toJson() => {
        "livetvurl": livetvurl,
      };
}
