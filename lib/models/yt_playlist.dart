// To parse this JSON data, do
//
//     final playList = playListFromJson(jsonString);

import 'dart:convert';

List<PlayList> playListFromJson(String str) =>
    List<PlayList>.from(json.decode(str).map((x) => PlayList.fromJson(x)));

String playListToJson(List<PlayList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlayList {
  PlayList({
    required this.featuredNews,
    required this.featuredInterview,
    required this.newsbulletin,
    required this.interview,
  });

  String featuredNews;
  String featuredInterview;
  List<Newsbulletin> newsbulletin;
  List<Interview> interview;

  factory PlayList.fromJson(Map<String, dynamic> json) => PlayList(
        featuredNews: json["featuredNews"],
        featuredInterview: json["featuredInterview"],
        newsbulletin: List<Newsbulletin>.from(
            json["newsbulletin"].map((x) => Newsbulletin.fromJson(x))),
        interview: List<Interview>.from(
            json["Interview"].map((x) => Interview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "featuredNews": featuredNews,
        "featuredInterview": featuredInterview,
        "newsbulletin": List<dynamic>.from(newsbulletin.map((x) => x.toJson())),
        "Interview": List<dynamic>.from(interview.map((x) => x.toJson())),
      };
}

class Interview {
  Interview({
    required this.featuredInterview,
    required this.interviewname,
    required this.featuredInterviewdate,
  });

  String featuredInterview;
  String interviewname;
  String featuredInterviewdate;

  factory Interview.fromJson(Map<String, dynamic> json) => Interview(
        featuredInterview: json["featuredInterview"],
        interviewname: json["Interviewname"],
        featuredInterviewdate: json["featuredInterviewdate"],
      );

  Map<String, dynamic> toJson() => {
        "featuredInterview": featuredInterview,
        "Interviewname": interviewname,
        "featuredInterviewdate": featuredInterviewdate,
      };
}

class Newsbulletin {
  Newsbulletin({
    required this.videoid,
    required this.video,
    required this.videotitle,
    required this.videodt,
  });

  String videoid;
  String video;
  String videotitle;
  String videodt;

  factory Newsbulletin.fromJson(Map<String, dynamic> json) => Newsbulletin(
        videoid: json["videoid"],
        video: json["video"],
        videotitle: json["videotitle"],
        videodt: json["videodt"],
      );

  Map<String, dynamic> toJson() => {
        "videoid": videoid,
        "video": video,
        "videotitle": videotitle,
        "videodt": videodt,
      };
}
