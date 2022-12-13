import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../models/association_members.dart';
import '../models/association_model.dart';
import '../models/b2b_model.dart';
import '../models/circular.dart';
import '../models/fav_deals.dart';
import '../models/live_tv_model.dart';
import '../models/login.dart';
import 'helper.dart';


class Apis {
  static Future<List<Association>?> getAssociationList(
      {String time = ''}) async {
    try {
      var response =
          await Dio().get(AssociationHelper.URL_LIST_OF_ASSOCIATION + time);
      if (response.statusCode == 200) {
        var data = jsonEncode(response.data);
        var mydata = associationListFromJson(data);
        return mydata[0].association;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<LoginModel?> getUserLogin({required String url}) async {
    try {
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var mydata = loginModelFromJson(response.toString());
        return mydata;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<List<B2BModel>?> getB2BList({
    String time = '',
    required String url,
  }) async {
    try {
      var response = await Dio().get(url + time);
      if (response.statusCode == 200) {
        var mydata = b2BModelFromJson(response.toString());
        return mydata;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }
  static Future<List<B2BModel>?> getB2BdemandList({
    String time = '',
    required String url,
  }) async {
    try {
      var response = await Dio().get(url + time);
      if (response.statusCode == 200) {
        var mydata = b2BModelFromJson(response.toString());
        return mydata;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<CircularAndUpdates?> getCirculars({
    String time = '',
    required String assId,
  }) async {
    String url =
        'http://travelworldonline.in/travelvideojson/circularsandupdates/?assoid=$assId&t=$time';
    try {
      var response = await Dio().get(url + time);
      if (response.statusCode == 200) {
        var data = response.toString();
        data = data.replaceAll('	', '');
        var mydata = circularAndUpdatesFromJson(data);
        return mydata[0];
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<AssociationMember?> getMembers({required String url}) async {
    try {
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var data = jsonEncode(response.data);
        var mydata = associationMemberFromJson(data);
        return mydata[0];
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<List<FavoriteDeal>?> getfavDeals({
    required String id,
    required String userid,
    required String password,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/travelvideojson/b2b/favourite/view/?assoid=$id&userid=$userid&password=$password';
      var response = await Dio().get(url);

      if (response.statusCode == 200) {
        //   var data = jsonEncode(response.data);
        var mydata = favDealsFromJson(response.toString());

        return mydata[0].favoriteDeals;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<String?> getPassword({
    required String org,
    required String userId,
    required String assid,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/twoapp/email_verify/EmailVerify.aspx?userid=$userId&assoid=$assid&assoname=$org';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        int res = int.parse(response.data);
        if (res == 0) {
          return "Email is not registered with $org";
        } else if (res == 1) {
          return "Dear User,\nWe have sent password on your email id.\n Please check spam folder in case you do not receive email within 5 minutes.\nIf you still have any issue than please contact us at support@travelworldonline.in";
        } else {
          return "We have encountered an issue while verifying email. Please try later";
        }
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<String?> getLiveTVUrl({
    required String org,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/travelvideojson/assolivetv/?shortname=$org';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var myData = liveTvModelFromJson(response.toString());
        return myData.livetvurl;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<String?> postFavDeals({
    required String assId,
    required String userid,
    required String password,
    required String fId,
    required String mName,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/travelvideojson/b2b/favourite/insert/?fid=$fId&mname=$mName&assoid=$assId&userid=$userid&password=$password';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var myData = response.data;
        if (myData.contains('success')) {
          return 'Deal added successfully';
        } else {
          return myData;
        }
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<String?> deleateFavDeal({
    required String sNo,
    required String userid,
    required String password,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/travelvideojson/b2b/favourite/delete/?sno=$sNo&userid=$userid&password=$password';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var myData = response.data;
        if (myData.contains('success')) {
          return 'Deal deleted successfully';
        } else {
          return myData;
        }
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<String?> deleateDeals({
    required String uniqueId,
    required String username,
    required String password,
    required String package,
  }) async {
    try {
      String url =
          'https://travelworldonline.in/travelvideojson/b2b/delete/?mname=$package&userid=$username&id=$uniqueId&&password=$password';

      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var myData = response.data;
        if (myData.contains('success')) {
          return 'Deal deleted successfully';
        } else {
          return myData;
        }
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  static Future<bool> createDeals({
    required Map<String, String> body,
    required String url,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          url,
        ),
      );
      request.fields.addAll(body);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var myData = await response.stream.bytesToString();

        if (myData.contains('success')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
      rethrow;
    }
  }

  static Future<bool> createDemand({
    required Map<String, String> body,
    required String url,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          url,
        ),
      );
      request.fields.addAll(body);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var myData = await response.stream.bytesToString();

        if (myData.contains('success')) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
      rethrow;
    }
  }
}
