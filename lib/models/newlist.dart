// To parse this JSON data, do
//
//     final articleList = articleListFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:travel_app/models/enum_value.dart';



List<ArticleList> articleListFromJson(String str) => List<ArticleList>.from(
      json.decode(str).map(
            (x) => ArticleList.fromJson(x),
          ),
    );

String articleListToJson(List<ArticleList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArticleList {
  ArticleList({
    required this.cDate,
    required this.jsonno,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.g1,
    required this.g2,
    required this.g3,
    required this.radiomaska,
    required this.travelworldonline,
    required this.amritwaniradio,
    required this.islamicradio,
    required this.videodetail,
    required this.hotnews,
  });

  String cDate;
  String jsonno;
  String t1;
  String t2;
  String t3;
  String g1;
  String g2;
  String g3;
  String radiomaska;
  String travelworldonline;
  String amritwaniradio;
  String islamicradio;
  List<Hotnew> videodetail;
  List<Hotnew> hotnews;

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
        cDate: json["CDate"],
        jsonno: json["jsonno"],
        t1: json["t1"],
        t2: json["t2"],
        t3: json["t3"],
        g1: json["g1"],
        g2: json["g2"],
        g3: json["g3"],
        radiomaska: json["Radiomaska"],
        travelworldonline: json["Travelworldonline"],
        amritwaniradio: json["Amritwaniradio"],
        islamicradio: json["islamicradio"],
        videodetail: List<Hotnew>.from(
          json["videodetail"].map(
            (x) => Hotnew.fromJson(x),
          ),
        ),
        hotnews:
            List<Hotnew>.from(json["Hotnews"].map((x) => Hotnew.fromJson(x))),
      );
  
  Map<String, dynamic> toJson() => {
        "CDate": cDate,
        "jsonno": jsonno,
        "t1": t1,
        "t2": t2,
        "t3": t3,
        "g1": g1,
        "g2": g2,
        "g3": g3,
        "Radiomaska": radiomaska,
        "Travelworldonline": travelworldonline,
        "Amritwaniradio": amritwaniradio,
        "islamicradio": islamicradio,
        "videodetail": List<dynamic>.from(videodetail.map((x) => x.toJson())),
        "Hotnews": List<dynamic>.from(hotnews.map((x) => x.toJson())),
      };
}

class Hotnew {
  Hotnew({
    required this.videoid,
    required this.videocate,
    required this.cateimg,
    required this.nationalinternational,
    required this.state,
    required this.videoname,
    required this.image,
    required this.video,
    required this.audio,
    required this.detail,
    required this.newsby,
    required this.createdt,
  });

  String videoid;
  Videocate? videocate;
  String cateimg;
  String nationalinternational;
  String state;
  String videoname;
  String image;
  String video;
  String audio;
  String detail;
  String newsby;
  String createdt;

  factory Hotnew.fromJson(Map<String, dynamic> json) => Hotnew(
        videoid: json["videoid"],
        videocate: videocateValues.map![json["videocate"]],
        cateimg: json["cateimg"],
        nationalinternational: json["nationalinternational"],
        state: json["state"],
        videoname: json["videoname"],
        image: json["image"],
        video: json["video"],
        audio: '${json["audio"]}'.replaceAll('/img/', '/audio/'),
        detail: json["detail"],
        newsby: json["newsby"],
        createdt: json["createdt"],
      );

  Map<String, dynamic> toJson() => {
        "videoid": videoid,
        "videocate": videocateValues.reverse[videocate],
        "cateimg": cateimg,
        "nationalinternational":
            nationalinternationalValues.reverse[nationalinternational],
        "state": state,
        "videoname": videoname,
        "image": image,
        "video": video,
        "audio": audio,
        "detail": detail,
        "newsby": newsbyValues.reverse[newsby],
        "createdt": createdt,
      };
}

enum Nationalinternational { DOMESTIC, INTERNATIONAL }

final nationalinternationalValues = EnumValues({
  "Domestic": Nationalinternational.DOMESTIC,
  "International": Nationalinternational.INTERNATIONAL
});

enum Newsby { TWO_BUREAU }

final newsbyValues = EnumValues({"TWO Bureau": Newsby.TWO_BUREAU});

enum Videocate {
  TRAVEL_AGENTS,
  TOURISM_BOARDS,
  AIRLINES,
  DESTINATIONS,
  MISCELLANEOUS,
  TOUR_OPERATORS,
  HOTELS
}

final videocateValues = EnumValues({
  "Airlines": Videocate.AIRLINES,
  "Destinations": Videocate.DESTINATIONS,
  "Hotels": Videocate.HOTELS,
  "Miscellaneous": Videocate.MISCELLANEOUS,
  "Tourism Boards": Videocate.TOURISM_BOARDS,
  "Tour Operators": Videocate.TOUR_OPERATORS,
  "Travel Agents": Videocate.TRAVEL_AGENTS
});
