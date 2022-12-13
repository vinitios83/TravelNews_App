import 'package:get/get.dart';
import '../models/ads_model.dart';
import 'remote_api.dart';

class AdsController extends GetxController {
  var isLoading = true.obs;

  var bannerAds = <AdsArray>[].obs;
  var nativeAds = <AdsArray>[].obs;
  var ads = <AdsArray>[].obs;
//=====================================
  var airlinesAds = <AdsArray>[].obs;
  var hotNewsAds = <AdsArray>[].obs;
  var destinationAds = <AdsArray>[].obs;
  var hotelAds = <AdsArray>[].obs;
  var tourismAds = <AdsArray>[].obs;
  var tourAds = <AdsArray>[].obs;
  var travelAds = <AdsArray>[].obs;
  var randomAds = <AdsArray>[].obs;
//======================================
  RxInt maxNativeAds = 0.obs;
  RxInt refreshRate = 0.obs;
  RxInt nativeAdsAfter = 0.obs;

  @override
  void onInit() {
    initAds();
    super.onInit();
  }

  void initAds() async {
    try {
      isLoading(true);

      ads.clear();
      bannerAds.clear();
      nativeAds.clear();
      String url =
          'http://travelworldonline.in/app_ads/ads_json.json?t=${DateTime.now().toIso8601String()}';
      if (ads.isEmpty) {
        ads.clear();
        bannerAds.clear();
        nativeAds.clear();
        var res = await RemoteApi().getAds(url: url);
        if (res != null) {
          ads.clear();
          bannerAds.clear();
          nativeAds.clear();
          hotNewsAds.clear();
          airlinesAds.clear();
          hotelAds.cast();
          maxNativeAds.value = int.parse(res.showMaxNativeAds);
          refreshRate.value = int.parse(res.bannerRefreshRate);
          nativeAdsAfter.value = int.parse(res.showNativeAfterNItems);

          for (var myAds in res.adsArray) {
            ads.add(myAds);

            if (myAds.adstype == 'NATIVE') {
              nativeAds.add(myAds);
              if (myAds.placement == 'hotnews') {
                hotNewsAds.add(myAds);
              }
              if (myAds.placement == 'airlines') {
                airlinesAds.add(myAds);
              }
              if (myAds.placement == 'hotels') {
                hotelAds.add(myAds);
              }
            }
            if (myAds.adstype == 'BANNER_300x50') {
              bannerAds.add(myAds);
            }
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
