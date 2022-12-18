// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_app/models/CampusDataModel.dart';
import 'package:travel_app/models/tourism_PPP.dart';
import 'package:travel_app/models/travel_ppp.dart';
import '../models/ads_model.dart';
import '../models/newlist.dart';
import '../models/yt_hot_deal.dart';
import '../models/yt_playlist.dart';
import '../utility/constant.dart';
import '../version/version_model.dart';

class RemoteApi {
  Future<TravelPPP?> getTravelPPPHome() async {
    try {
      var response = await Dio().get(AppConstants.getTravelPPPHomeUrl);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        TravelPPP? mydata = TravelPPP.fromJson(data);
        return mydata;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }

  Future<TourismPpp?> getTourismPPPHome(String id) async {
    try {
      var response = await Dio().get(AppConstants.getTourismPPPUrl+"?id=$id");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        var mydata = TourismPpp.fromJson(data);
        return mydata;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }

  Future<dynamic?> getTourismPPPData(category, subcategory) async {
    try {
      var response = await Dio().get(
          "https://travelworldonline.in/travelnationalinternational/TNI_json/TNISectionContent.aspx?travelniid=1&category=" +
              category +
              "&subcategory=" +
              subcategory);
              print(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        return data;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }

  Future<ArticleList?> getArticlesList() async {
    try {
      var response = await Dio().get(AppConstants.getNewsArticlesUrl);
      if (response.statusCode == 200) {
        var data = jsonEncode(response.data);
        var mydata = articleListFromJson(data);
        return mydata[0];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }

  Future<PlayList?> getPlayList() async {
    try {
      var response = await Dio().get(AppConstants.getYouTubePlaylistUrl);
      if (response.statusCode == 200) {
        String res = response.data;
        res = res.replaceFirst('•	', '');
        var mydata = playListFromJson(res);
        return mydata[0];
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  Future<List<Hotdeal>?> getHotDeals() async {
    try {
      var response = await Dio().get(AppConstants.ytHotDeals);
      if (response.statusCode == 200) {
        var data = jsonEncode(response.data);
        var mydata = youTubeDealsFromJson(data);
        return mydata[0].hotdeals;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  Future<AdsModel?> getAds({required String url}) async {
    try {
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var data = jsonEncode(response.data);
        var mydata = adsModelFromJson(data);
        return mydata[0];
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }

  Future<VersionModel?> getVersion({required String url}) async {
    try {
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        var mydata = versionModelFromJson(response.toString());
        return mydata;
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
    }
    return null;
  }
  Future<CampusCategoryList?> getCampusCategoryList() async {
    try {
      var response = await Dio().get(AppConstants.getCampusCategoryList);
      if (response.statusCode == 200) {
        var mydata = CampusCategoryList.fromJson(json.decode(response.data.trim()));
        return mydata;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }
  Future<CampusCategoryList?> getSubCanpusCategory(categoryid) async {
    try {
      var response = await Dio().get(
        'https://travelworldonline.in/travelvideojson/videosubcat/?id=$categoryid');
              print(response);
      if (response.statusCode == 200) {
        var mydata = CampusCategoryList.fromJson(json.decode(response.data.trim()));
        return mydata;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }
  Future<CampusCategoryList?> getCanpusCategoryVideoList(categoryid,subCategoryid) async {
    try {
      var response = await Dio().get(
        'https://travelworldonline.in/travelvideojson/campusvideo/?catid=$categoryid&subcatid=$subCategoryid');
              print(response);
      if (response.statusCode == 200) {
        var mydata = CampusCategoryList.fromJson(json.decode(response.data.trim()));
        return mydata;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    return null;
  }
  
}
