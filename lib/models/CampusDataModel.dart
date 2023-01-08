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
  String? subsubcat;
  String? place;

  CampusCategory({this.id, this.videocat});

  CampusCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videocat = json['videocat'];
    videosubcat = json['videosubcat'];
    image = json['image'];
    video = json['video'];
    detail = json['detail'];
    heading = json['heading'];
    subsubcat = json['subsubcat'];
    place = json['place'];
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
    data['subsubcat'] = this.subsubcat;
    data['place'] = this.place;
    return data;
  }
}

class ProfileList {
  List<AdvisoryProfile>? advisoryProfileList;

  ProfileList({this.advisoryProfileList});

  ProfileList.fromJson(List<dynamic> result) {
    Map<String, dynamic> json = result.first;
    if (json['tblvideocats'] != null) {
      advisoryProfileList = <AdvisoryProfile>[];
      json['tblvideocats'].forEach((v) {
        advisoryProfileList!.add(new AdvisoryProfile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advisoryProfileList != null) {
      data['tblvideocats'] = this.advisoryProfileList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvisoryProfile {
  String? id;
  String? image;
  String? name;
  String? bio;

  AdvisoryProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['bio'] = this.bio;
    return data;
  }
}

class CourseList {
  List<Course>? courseList;

  CourseList({this.courseList});

  CourseList.fromJson(List<dynamic> result) {
    Map<String, dynamic> json = result.first;
    if (json['tblvideocats'] != null) {
      courseList = <Course>[];
      json['tblvideocats'].forEach((v) {
        courseList!.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courseList != null) {
      data['tblvideocats'] = this.courseList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  String? id;
  String? name;
  String? link;

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}