import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/fav_deals.dart';
import '../models/login.dart';

import '../models/b2b_model.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';

class B2BController extends GetxController {
  var isLoading = false.obs;

  var b2bListPackages = <Hotel>[].obs;
  var b2bListHotel = <Hotel>[].obs;
  var b2bListTransport = <Transport>[].obs;
  var ticker = <LoginModel>{}.obs;

  var favListPackages = <Hotel>[].obs;
  var favListHotel = <Hotel>[].obs;
  var favListTransport = <Transport>[].obs;

  var myListPackages = <Hotel>[].obs;
  var myListHotel = <Hotel>[].obs;
  var myListTransport = <Transport>[].obs;

  var allFavDeals = <FavoriteDeal>[].obs;

  String getLoginUrl({
    required String aUserName,
    required String aUserPassword,
    required String aName,
    required String aId,
  }) {
    String url = AssociationHelper.URL_LOGIN;
    url = url.replaceAll("mmituser", aUserName);
    url = url.replaceAll("mmitpassword", aUserPassword);
    url = url.replaceAll("ASSOCIATION_NAME", aName);
    url = url.replaceAll("ASSOID", aId);
    return url;
  }

  Future<bool> getUserLogin({
    required String aUserName,
    required String aUserPassword,
    required String aName,
    required String aId,
  }) async {
    ticker.clear();
    String loginUrl = getLoginUrl(
      aUserName: aUserName,
      aUserPassword: aUserPassword,
      aName: aName,
      aId: aId,
    );
    isLoading(true);
    ticker.clear();

    var res = await Apis.getUserLogin(url: loginUrl);
    if (res != null && res.loginstatus == 'Yes') {
      ticker.add(res);
      isLoading(false);
      return true;
    } else {
      isLoading(false);
      return false;
    }
  }

  Future<void> fetchB2BDeals() async {
    // b2bListPackages.clear();
    // b2bListHotel.clear();
    // b2bListTransport.clear();
    var b2burl = AssociationHelper.B2BDeals;

    try {
      isLoading(true);
      
      if (b2bListHotel.isEmpty) {
        isLoading(true);
        b2bListPackages.clear();
      b2bListHotel.clear();
      b2bListTransport.clear();
      }
      var b2b = await Apis.getB2BList(url: b2burl);
      if (b2b != null) {
        b2bListPackages.clear();
        b2bListHotel.clear();
        b2bListTransport.clear();
        b2bListPackages.addAll(b2b[0].package);
        b2bListHotel.addAll(b2b[0].hotel);
        b2bListTransport.addAll(b2b[0].transport);
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchB2Bbuyer() async {
    // b2bListPackages.clear();
    // b2bListHotel.clear();
    // b2bListTransport.clear();

    var b2bbuyerurl = AssociationHelper.B2BbuyersDeals;
    try {
      isLoading(true);
      if (b2bListHotel.isEmpty) {
        isLoading(true);
        b2bListPackages.clear();
        b2bListHotel.clear();
        b2bListTransport.clear();
      }
      var b2b = await Apis.getB2BList(url: b2bbuyerurl);
      if (b2b != null) {
        b2bListPackages.clear();
        b2bListHotel.clear();
        b2bListTransport.clear();
        b2bListPackages.addAll(b2b[0].package);
        b2bListHotel.addAll(b2b[0].hotel);
        b2bListTransport.addAll(b2b[0].transport);
      }
    } catch (e) {
      FlutterError.presentError(FlutterErrorDetails(exception: e));
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchFavDeals({
    required String id,
    required String userid,
    required String password,
  }) async {
    isLoading(true);
    
    try {
      if (favListHotel.isEmpty) {
        isLoading(true);
        favListHotel.clear();
        favListPackages.clear();
        favListTransport.clear();
        allFavDeals.clear();
      }

      var favDeals =
          await Apis.getfavDeals(id: id, userid: userid, password: password);
      if (favDeals != null) {
        favListHotel.clear();
        favListPackages.clear();
        favListTransport.clear();
        allFavDeals.clear();
        allFavDeals.addAll(favDeals);
        for (var myDeals in favDeals) {
          if (myDeals.mname.toLowerCase() == 'package') {
            for (var package in b2bListPackages) {
              if (package.id == myDeals.fid) {
                favListPackages.add(package);
                break;
              }
            }
          } else if (myDeals.mname.toLowerCase() == 'hotel') {
            for (var hotel in b2bListHotel) {
              if (hotel.id == myDeals.fid) {
                favListHotel.add(hotel);
                break;
              }
            }
          } else if (myDeals.mname.toLowerCase() == 'transport') {
            for (var transport in b2bListTransport) {
              if (transport.id == myDeals.fid) {
                favListTransport.add(transport);
                break;
              }
            }
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMyDeals({
    required String userid,
  }) async {
    myListHotel.clear();
    myListPackages.clear();
    myListTransport.clear();
    try {
      if (myListHotel.isEmpty) {
        isLoading(true);
        myListHotel.clear();
        myListPackages.clear();
        myListTransport.clear();
      }

      for (var package in b2bListPackages) {
        if (package.userid == userid) {
          myListPackages.add(package);
        }
      }

      for (var hotel in b2bListHotel) {
        if (hotel.userid == userid) {
          myListHotel.add(hotel);
        }
      }
      for (var transport in b2bListTransport) {
        if (transport.userid == userid) {
          myListTransport.add(transport);
        }
      }
      return;
    } finally {
      isLoading(false);
      return;
    }
    
  }



  Future<String> deleteFavDeals({
    required String userid,
    required String password,
    required String uniqueId,
  }) async {
    try {
      String sNo = '';
      for (var deals in allFavDeals) {
        if (deals.fid == uniqueId) {
          sNo = deals.sno;
          break;
        }
      }

      String? response = await Apis.deleateFavDeal(
        sNo: sNo,
        userid: userid,
        password: password,
      );
      return '$response';
    } finally {
      isLoading(false);
    }
  }
}
