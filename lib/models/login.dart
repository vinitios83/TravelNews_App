import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.loginstatus,
    required this.username,
    required this.tickertext,
  });

  String loginstatus;
  String username;
  String tickertext;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        loginstatus: json["loginstatus"],
        username: json["username"],
        tickertext: json["tickertext"],
      );

  Map<String, dynamic> toJson() => {
        "loginstatus": loginstatus,
        "username": username,
        "tickertext": tickertext,
      };
}
