import 'dart:convert';

List<AssociationMember> associationMemberFromJson(String str) =>
    List<AssociationMember>.from(
        json.decode(str).map((x) => AssociationMember.fromJson(x)));

String associationMemberToJson(List<AssociationMember> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class AssociationMember {
  AssociationMember({
    required this.cDate,
    required this.jsonno,
    required this.chapterChairman,
    required this.directors,
    required this.members,
  });

  final String cDate;
  final String jsonno;
  final List<ChapterChairman> chapterChairman;
  final List<ChapterChairman> directors;
  final List<ChapterChairman> members;

  factory AssociationMember.fromJson(Map<String, dynamic> json) =>
      AssociationMember(
        cDate: json["CDate"],
        jsonno: json["jsonno"],
        chapterChairman: List<ChapterChairman>.from(
            json["chapter_chairman"].map((x) => ChapterChairman.fromJson(x))),
        directors: List<ChapterChairman>.from(
            json["directors"].map((x) => ChapterChairman.fromJson(x))),
        members: List<ChapterChairman>.from(
            json["members"].map((x) => ChapterChairman.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CDate": cDate,
        "jsonno": jsonno,
        "chapter_chairman":
            List<dynamic>.from(chapterChairman.map((x) => x.toJson())),
        "directors": List<dynamic>.from(directors.map((x) => x.toJson())),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
      };
}

class ChapterChairman {
  ChapterChairman({
    required this.memberid,
    required this.cname,
    required this.mStatus,
    required this.category,
    required this.address1,
    required this.address2,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.phone,
    required this.phonefx,
    required this.email1,
    required this.email2,
    required this.mname,
    required this.mdesignation,
    required this.profile1,
    required this.profile2,
    required this.profile3,
    required this.photo,
  });

  final String memberid;
  final String cname;
  final String mStatus;
  final String category;
  final String address1;
  final String address2;
  final String city;
  final String pinCode;
  final String state;
  final String phone;
  final String phonefx;
  final String email1;
  final String email2;
  final String mname;
  final String mdesignation;
  final String profile1;
  final String profile2;
  final String profile3;
  final String photo;

  factory ChapterChairman.fromJson(Map<String, dynamic> json) =>
      ChapterChairman(
        memberid: json["memberid"] ?? '',
        cname: json["cname"] ?? '',
        mStatus: json["m_status"] ?? '',
        category: json["category"] ?? '',
        address1: json["address1"] ?? '',
        address2: json["address2"] ?? '',
        city: json["city"] ?? '',
        pinCode: json["pin_code"] ?? '',
        state: json["state"] ?? '',
        phone: json["phone"] ?? '',
        phonefx: json["phonefx"] ?? '',
        email1: json["email1"] ?? '',
        email2: json["email2"] ?? '',
        mname: json["mname"] ?? '',
        mdesignation: json["mdesignation"] ?? '',
        profile1: json["profile1"] ?? '',
        profile2: json["profile2"] ?? '',
        profile3: json["profile3"] ?? '',
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "memberid": memberid,
        "cname": cname,
        "m_status": mStatus,
        "category": category,
        "address1": address1,
        "address2": address2,
        "city": city,
        "pin_code": pinCode,
        "state": state,
        "phone": phone,
        "phonefx": phonefx,
        "email1": email1,
        "email2": email2,
        "mname": mname,
        "mdesignation": mdesignation,
        "profile1": profile1,
        "profile2": profile2,
        "profile3": profile3,
        "photo": photo,
      };
}
