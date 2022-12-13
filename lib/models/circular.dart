import 'dart:convert';

List<CircularAndUpdates> circularAndUpdatesFromJson(String str) =>
    List<CircularAndUpdates>.from(
      json.decode(str).map(
            (x) => CircularAndUpdates.fromJson(x),
          ),
    );

String circularAndUpdatesToJson(List<CircularAndUpdates> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CircularAndUpdates {
  CircularAndUpdates({
    required this.circular,
    required this.updates,
  });

  List<Circular> circular;
  List<Circular> updates;

  factory CircularAndUpdates.fromJson(Map<String, dynamic> json) =>
      CircularAndUpdates(
        circular: List<Circular>.from(
            json["circular"].map((x) => Circular.fromJson(x))),
        updates: List<Circular>.from(
            json["updates"].map((x) => Circular.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "circular": List<dynamic>.from(circular.map((x) => x.toJson())),
        "updates": List<dynamic>.from(updates.map((x) => x.toJson())),
      };
}

class Circular {
  Circular({
    required this.title,
    required this.text,
    required this.date,
    required this.img,
  });

  String title;
  String text;
  String date;
  String img;

  factory Circular.fromJson(Map<String, dynamic> json) => Circular(
        title: json["title"],
        text: json["text"],
        date: json["date"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
        "date": date,
        "img": img,
      };
}
