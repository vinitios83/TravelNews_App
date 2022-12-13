import 'dart:convert';

List<AdsModel> adsModelFromJson(String str) =>
    List<AdsModel>.from(json.decode(str).map((x) => AdsModel.fromJson(x)));

String adsModelToJson(List<AdsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdsModel {
  AdsModel({
    required this.bannerRefreshRate,
    required this.showNativeAfterNItems,
    required this.showMaxNativeAds,
    required this.adsArray,
  });

  final String bannerRefreshRate;
  final String showNativeAfterNItems;
  final String showMaxNativeAds;
  final List<AdsArray> adsArray;

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        bannerRefreshRate: json["bannerRefreshRate"],
        showNativeAfterNItems: json["showNativeAfterNItems"],
        showMaxNativeAds: json["showMaxNativeAds"],
        adsArray: List<AdsArray>.from(
            json["adsArray"].map((x) => AdsArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bannerRefreshRate": bannerRefreshRate,
        "showNativeAfterNItems": showNativeAfterNItems,
        "showMaxNativeAds": showMaxNativeAds,
        "adsArray": List<dynamic>.from(adsArray.map((x) => x.toJson())),
      };
}

class AdsArray {
  AdsArray({
    required this.id,
    required this.actionname,
    required this.adstype,
    required this.refreshduration,
    required this.callnumber,
    required this.hiturl,
    required this.imageurl,
    required this.placement,
    required this.dealid,
  });

  final String id;
  final String actionname;
  final String adstype;
  final String refreshduration;
  final String callnumber;
  final String hiturl;
  final String imageurl;
  final String placement;
  final String dealid;

  factory AdsArray.fromJson(Map<String, dynamic> json) => AdsArray(
        id: json["id"],
        actionname: json["actionname"],
        adstype: json["adstype"],
        refreshduration: json["refreshduration"],
        callnumber: json["callnumber"],
        hiturl: json["hiturl"],
        imageurl: json["imageurl"],
        placement: json["placement"],
        dealid: json["dealid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actionname": actionname,
        "adstype": adstype,
        "refreshduration": refreshduration,
        "callnumber": callnumber,
        "hiturl": hiturl,
        "imageurl": imageurl,
        "placement": placement,
        "dealid": dealid,
      };
}
