import 'dart:convert';

List<FavDeals> favDealsFromJson(String str) =>
    List<FavDeals>.from(json.decode(str).map((x) => FavDeals.fromJson(x)));

String favDealsToJson(List<FavDeals> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavDeals {
  FavDeals({
    required this.favoriteDeals,
  });

  final List<FavoriteDeal> favoriteDeals;

  factory FavDeals.fromJson(Map<String, dynamic> json) => FavDeals(
        favoriteDeals: List<FavoriteDeal>.from(
            json["favoriteDeals"].map((x) => FavoriteDeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "favoriteDeals":
            List<dynamic>.from(favoriteDeals.map((x) => x.toJson())),
      };
}

class FavoriteDeal {
  FavoriteDeal({
    required this.sno,
    required this.fid,
    required this.mname,
    required this.assoid,
    required this.userid,
  });

  final String sno;
  final String fid;
  final String mname;
  final String assoid;
  final String userid;

  factory FavoriteDeal.fromJson(Map<String, dynamic> json) => FavoriteDeal(
        sno: json["sno"],
        fid: json["fid"],
        mname: json["mname"],
        assoid: json["assoid"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "sno": sno,
        "fid": fid,
        "mname": mname,
        "assoid": assoid,
        "userid": userid,
      };
}
