import 'dart:convert';

import 'package:get/get.dart';

import '../services/associations_api.dart';


class CreateDemandController extends GetxController {
  var isLoading = false.obs;

  Future<bool> createBuyerPackage({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/demands/insert/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/demands/update/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

      String stringBody = jsonEncode(body);
      Map<String, String> dataToPost = {
        'packagejson': stringBody,
        'module': 'packagemodules',
        'userid': username
      };

      bool res = await Apis.createDeals(body: dataToPost, url: url);
      return res;
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> createBuyerHotel({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/demands/insert/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/demands/update/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

      String stringBody = jsonEncode(body);

      Map<String, String> dataToPost = {
        'packagejson': stringBody,
        'module': 'hotelmodule',
        'userid': username
      };

      bool res = await Apis.createDeals(body: dataToPost, url: url);
      return res;
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> createBuyerTransport({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/demands/insert/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/demands/update/buyer/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

      String stringBody = jsonEncode(body);

      Map<String, String> dataToPost = {
        'packagejson': stringBody,
        'module': 'transportmodule',
        'userid': username
      };

      bool res = await Apis.createDeals(body: dataToPost, url: url);
      return res;
    } catch (e) {
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
