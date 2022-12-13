import 'dart:convert';

import 'package:get/get.dart';

import '../services/associations_api.dart';


class CreateDealController extends GetxController {
  var isLoading = false.obs;

  Future<bool> createPackage({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/insert/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/update/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

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

  Future<bool> createHotel({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/insert/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/update/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

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

  Future<bool> createTransport({
    required Map<String, String> body,
    required String username,
    required String password,
    required String time,
    bool isUpdate = false,
  }) async {
    try {
      isLoading(true);
      String url = (!isUpdate)
          ? 'https://travelworldonline.in/travelvideojson/b2b/insert/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone'
          : 'https://travelworldonline.in/travelvideojson/b2b/update/?t=$time&userid=$username&password=$password&width=1080&height=2160&platform=iphone';

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
