import 'dart:convert';

class CampusCategoryList {
  List<CampusCategory>? campusCategoryList;

  CampusCategoryList({this.campusCategoryList});

  CampusCategoryList.fromJson(List<dynamic> result) {
    Map<String, dynamic> json = result.first;
    if (json['tblvideocats'] != null) {
      campusCategoryList = <CampusCategory>[];
      json['tblvideocats'].forEach((v) {
        campusCategoryList!.add(new CampusCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campusCategoryList != null) {
      data['tblvideocats'] = this.campusCategoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampusCategory {
  String? id;
  String? videocat;
  String? videosubcat;
  String? image;
  String? video;
  String? detail;
  String? heading;

  CampusCategory({this.id, this.videocat});

  CampusCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videocat = json['videocat'];
    videosubcat = json['videosubcat'];
    image = json['image'];
    video = json['video'];
    detail = json['detail'];
    heading = json['heading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['videocat'] = this.videocat;
    data['videosubcat'] = this.videosubcat;
    data['image'] = this.image;
    data['video'] = this.video;
    data['detail'] = this.detail;
    data['heading'] = this.heading;
    return data;
  }
}
