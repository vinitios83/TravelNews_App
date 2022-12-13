import 'dart:convert';

List<YouTubeDeals> youTubeDealsFromJson(String str) => List<YouTubeDeals>.from(
    json.decode(str).map((x) => YouTubeDeals.fromJson(x)));

String youTubeDealsToJson(List<YouTubeDeals> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YouTubeDeals {
  YouTubeDeals({
    required this.featuredHotDeal,
    required this.hotdeals,
  });

  String featuredHotDeal;
  List<Hotdeal> hotdeals;

  factory YouTubeDeals.fromJson(Map<String, dynamic> json) => YouTubeDeals(
        featuredHotDeal: json["featuredHotDeal"],
        hotdeals: List<Hotdeal>.from(
            json["hotdeals"].map((x) => Hotdeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "featuredHotDeal": featuredHotDeal,
        "hotdeals": List<dynamic>.from(hotdeals.map((x) => x.toJson())),
      };
}

class Hotdeal {
  Hotdeal({
    required this.videoid,
    required this.video,
    required this.videoTitle,
  });

  String videoid;
  String video;
  String videoTitle;

  factory Hotdeal.fromJson(Map<String, dynamic> json) => Hotdeal(
        videoid: json["videoid"],
        video: json["video"],
        videoTitle: json["video_title"],
      );

  Map<String, dynamic> toJson() => {
        "videoid": videoid,
        "video": video,
        "video_title": videoTitle,
      };
}
