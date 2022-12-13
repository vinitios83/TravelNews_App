import 'package:get/get.dart';
import 'package:new_version/new_version.dart';

import '../services/remote_api.dart';

class VersionController extends GetxController {
  var isLoading = true.obs;

  RxString latestVersion = ''.obs;
  RxString message = ''.obs;
  RxString package = ''.obs;
  RxString isforced = ''.obs;
  RxString maintenance = ''.obs;
  RxString youtubekey = ''.obs;
  RxString youtubedefault = ''.obs;
  RxBool canUpdate = false.obs;
  RxString appStoreLink = ''.obs;

  @override
  void onInit() {
    initVersion();
    super.onInit();
  }

  void initVersion() async {
    try {
      final newVersion = NewVersion();
      isLoading(true);
      final status = await newVersion.getVersionStatus();
      latestVersion.value = '';
      message.value = '';
      String url =
          'https://storyatoz.com/travelWorldOnline/version_control/version_handler_release%20_iphone.json?t=${DateTime.now().toIso8601String()}';
      if (latestVersion.isEmpty) {
        var res = await RemoteApi().getVersion(url: url);
        if (res != null) {
          latestVersion.value = res.latestversion;
          message.value = res.message;
          package.value = res.package;
          isforced.value = res.isforced;
          maintenance.value = res.maintenance;
          youtubekey.value = res.youtubekey;
          youtubedefault.value = res.youtubedefault;
        }
        if (status != null) {
          canUpdate.value = status.canUpdate;
          appStoreLink.value = status.appStoreLink;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
