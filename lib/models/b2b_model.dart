import 'dart:convert';

List<B2BModel> b2BModelFromJson(String str) =>
    List<B2BModel>.from(json.decode(str).map((x) => B2BModel.fromJson(x)));

String b2BModelToJson(List<B2BModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class B2BModel {
  B2BModel({
    required this.package,
    required this.hotel,
    required this.transport,
  });

  List<Hotel> package;
  List<Hotel> hotel;
  List<Transport> transport;

  factory B2BModel.fromJson(Map<String, dynamic> json) => B2BModel(
        package:
            List<Hotel>.from(json["Package"].map((x) => Hotel.fromJson(x))),
        hotel: List<Hotel>.from(json["Hotel"].map((x) => Hotel.fromJson(x))),
        transport: List<Transport>.from(
            json["Transport"].map((x) => Transport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Package": List<dynamic>.from(package.map((x) => x.toJson())),
        "Hotel": List<dynamic>.from(hotel.map((x) => x.toJson())),
        "Transport": List<dynamic>.from(transport.map((x) => x.toJson())),
      };
}

class Hotel {
  Hotel({
    required this.id,
    required this.dealName,
    required this.dealType,
    required this.dealPublicPrice,
    required this.dealPrivatePrice,
    required this.dealInclusion,
    required this.dealHotelCategory,
    required this.dealDescription,
    required this.dealExpire,
    required this.state,
    required this.city,
    required this.contactPerson,
    required this.contactPemail,
    required this.contactNumber,
    required this.isfeatured,
    required this.formname,
    required this.userid,
    required this.createdt,
    required this.assoname,
    required this.dealDuration,
    required this.dealAirportStatus,
  });

  String id;
  String dealName;
  String dealType;
  String dealPublicPrice;
  String dealPrivatePrice;
  String dealInclusion;
  String dealHotelCategory;
  String dealDescription;
  String dealExpire;
  String state;
  String city;
  String contactPerson;
  String contactPemail;
  String contactNumber;
  String isfeatured;
  String formname;
  String userid;
  String createdt;
  String assoname;
  String? dealDuration;
  String? dealAirportStatus;

  factory Hotel.fromJson(Map<String, dynamic> json) => Hotel(
        id: json["id"],
        dealName: json["deal_name"],
        dealType: json["deal_type"],
        dealPublicPrice: json["deal_public_price"],
        dealPrivatePrice: json["deal_private_price"],
        dealInclusion: json["deal_inclusion"],
        dealHotelCategory: json["deal_hotel_category"],
        dealDescription: json["deal_description"],
        dealExpire: json["deal_expire"],
        state: json["state"],
        city: json["city"],
        contactPerson: json["contact_person"],
        contactPemail: json["contact_pemail"],
        contactNumber: json["contact_number"],
        isfeatured: json["isfeatured"],
        formname: json["formname"],
        userid: json["userid"],
        createdt: json["createdt"],
        assoname: json["assoname"],
        dealDuration: json["deal_duration"] ?? '',
        dealAirportStatus: json["deal_airport_status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deal_name": dealName,
        "deal_type": dealType,
        "deal_public_price": dealPublicPrice,
        "deal_private_price": dealPrivatePrice,
        "deal_inclusion": dealInclusion,
        "deal_hotel_category": dealHotelCategory,
        "deal_description": dealDescription,
        "deal_expire": dealExpire,
        "state": state,
        "city": city,
        "contact_person": contactPerson,
        "contact_pemail": contactPemail,
        "contact_number": contactNumber,
        "isfeatured": isfeatured,
        "formname": formname,
        "userid": userid,
        "createdt": createdt,
        "assoname": assoname,
        "deal_duration": dealDuration ?? '',
        "deal_airport_status": dealAirportStatus ?? '',
      };
}

class Transport {
  Transport({
    required this.id,
    required this.dealName,
    required this.vechicleCategory,
    required this.fuelType,
    required this.dailyRent,
    required this.costPerKm,
    required this.costPerHour,
    required this.costPerExtraHour,
    required this.dealDescription,
    required this.dealExpire,
    required this.state,
    required this.city,
    required this.contactPerson,
    required this.contactPemail,
    required this.contactNumber,
    required this.isfeatured,
    required this.formname,
    required this.userid,
    required this.createdt,
    required this.assoname,
  });

  String id;
  String dealName;
  String vechicleCategory;
  String fuelType;
  String dailyRent;
  String costPerKm;
  String costPerHour;
  String costPerExtraHour;
  String dealDescription;
  String dealExpire;
  String state;
  String city;
  String contactPerson;
  String contactPemail;
  String contactNumber;
  String isfeatured;
  String formname;
  String userid;
  String createdt;
  String assoname;

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        id: json["id"],
        dealName: json["deal_name"],
        vechicleCategory: json["vechicle_category"],
        fuelType: json["fuel_type"],
        dailyRent: json["daily_rent"],
        costPerKm: json["cost_per_km"],
        costPerHour: json["cost_per_hour"],
        costPerExtraHour: json["cost_per_extra_hour"],
        dealDescription: json["deal_description"],
        dealExpire: json["deal_expire"],
        state: json["state"],
        city: json["city"],
        contactPerson: json["contact_person"],
        contactPemail: json["contact_pemail"],
        contactNumber: json["contact_number"],
        isfeatured: json["isfeatured"],
        formname: json["formname"],
        userid: json["userid"],
        createdt: json["createdt"],
        assoname: json["assoname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deal_name": dealName,
        "vechicle_category": vechicleCategory,
        "fuel_type": fuelType,
        "daily_rent": dailyRent,
        "cost_per_km": costPerKm,
        "cost_per_hour": costPerHour,
        "cost_per_extra_hour": costPerExtraHour,
        "deal_description": dealDescription,
        "deal_expire": dealExpire,
        "state": state,
        "city": city,
        "contact_person": contactPerson,
        "contact_pemail": contactPemail,
        "contact_number": contactNumber,
        "isfeatured": isfeatured,
        "formname": formname,
        "userid": userid,
        "createdt": createdt,
        "assoname": assoname,
      };
}
