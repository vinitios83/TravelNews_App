// To parse this JSON data, do
//
//     final TravelPPP = TravelPPPFromJson(jsonString);

import 'dart:convert';

class TravelPPP {
  TravelPPP({
    required this.nationalTourismboardDetails,
    required this.internationalTourismboardDetails,
  });

  final InternationalTourismboardDetails nationalTourismboardDetails;
  final InternationalTourismboardDetails internationalTourismboardDetails;

  TravelPPP copyWith({
    InternationalTourismboardDetails? nationalTourismboardDetails,
    InternationalTourismboardDetails? internationalTourismboardDetails,
  }) =>
      TravelPPP(
        nationalTourismboardDetails:
            nationalTourismboardDetails ?? this.nationalTourismboardDetails,
        internationalTourismboardDetails: internationalTourismboardDetails ??
            this.internationalTourismboardDetails,
      );

  factory TravelPPP.fromRawJson(String str) =>
      TravelPPP.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TravelPPP.fromJson(json) => TravelPPP(
        nationalTourismboardDetails: InternationalTourismboardDetails.fromJson(
            json[0]["NationalTourismboardDetails"]),
        internationalTourismboardDetails:
            InternationalTourismboardDetails.fromJson(
                json[0]["InternationalTourismboardDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "NationalTourismboardDetails": nationalTourismboardDetails == null
            ? null
            : nationalTourismboardDetails.toJson(),
        "InternationalTourismboardDetails":
            internationalTourismboardDetails == null
                ? null
                : internationalTourismboardDetails.toJson(),
      };
}

class InternationalTourismboardDetails {
  InternationalTourismboardDetails({
    required this.content,
    required this.image,
    required this.countries,
  });

  final String content;
  final String image;
  final List<Country> countries;

  InternationalTourismboardDetails copyWith({
    required String content,
    required String image,
    required List<Country> countries,
  }) =>
      InternationalTourismboardDetails(
        content: content,
        image: image,
        countries: countries,
      );

  factory InternationalTourismboardDetails.fromRawJson(String str) =>
      InternationalTourismboardDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InternationalTourismboardDetails.fromJson(
          Map<String, dynamic> json) =>
      InternationalTourismboardDetails(
        content: json["content"],
        image: json["image"],
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "image": image,
        "countries": countries == null
            ? null
            : List<dynamic>.from(countries.map((x) => x.toJson())),
      };
}

class Country {
  Country({
    required this.id,
    required this.ni,
    required this.countryid,
    required this.state,
    required this.orgName,
    required this.city,
    required this.img,
    required this.address,
    required this.website,
    required this.emailid,
    required this.mobilenoe,
  });

  final String id;
  final String ni;
  final String countryid;
  final String state;
  final String orgName;
  final String city;
  final String img;
  final String address;
  final String website;
  final String emailid;
  final String mobilenoe;

  Country copyWith({
    String? id,
    String? ni,
    String? countryid,
    String? state,
    String? orgName,
    String? city,
    String? img,
    String? address,
    String? website,
    String? emailid,
    String? mobilenoe,
  }) =>
      Country(
        id: id ?? this.id,
        ni: ni ?? this.ni,
        countryid: countryid ?? this.countryid,
        state: state ?? this.state,
        orgName: orgName ?? this.orgName,
        city: city ?? this.city,
        img: img ?? this.img,
        address: address ?? this.address,
        website: website ?? this.website,
        emailid: emailid ?? this.emailid,
        mobilenoe: mobilenoe ?? this.mobilenoe,
      );

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"],
        ni: json["NI"],
        countryid: json["Countryid"],
        state: json["State"],
        orgName: json["OrgName"],
        city: json["City"],
        img: json["img"],
        address: json["Address"],
        website: json["Website"],
        emailid: json["Emailid"],
        mobilenoe: json["Mobilenoe"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NI": ni,
        "Countryid": countryid,
        "State": state,
        "OrgName": orgName,
        "City": city,
        "img": img,
        "Address": address,
        "Website": website,
        "Emailid": emailid,
        "Mobilenoe": mobilenoe,
      };
}
