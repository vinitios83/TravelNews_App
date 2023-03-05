import 'package:get/get.dart';
import '../models/login.dart';



import '../models/b2b_model.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';


class AssociationDetailController extends GetxController {
  var isLoading = true.obs;
  var auth = false.obs;

  var b2bListPackages = <Hotel>[].obs;
  var b2bListHotel = <Hotel>[].obs;
  var b2bListTransport = <Transport>[].obs;
  var ticker = <LoginModel>{}.obs;

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

  Future<void> fetchAssociationDeals({
    required String aUserName,
    required String aUserPassword,
    required String aName,
    required String aId,
  }) async {
    ticker.clear();
    b2bListPackages.clear();
    b2bListHotel.clear();
    b2bListTransport.clear();
    String loginUrl = getLoginUrl(
      aUserName: aUserName,
      aUserPassword: aUserPassword,
      aName: aName,
      aId: aId,
    );
    var b2burl = AssociationHelper.B2BDeals;
    try {
      if (ticker.isEmpty) {
        isLoading(true);
        ticker.clear();
        var res = await Apis.getUserLogin(url: loginUrl);
        if (res != null && res.loginstatus == 'Yes') {
          auth(true);
          ticker.add(res);
          if (b2bListHotel.isEmpty) {
            isLoading(true);
            b2bListPackages.clear();
            b2bListHotel.clear();
            b2bListTransport.clear();
          }
          String urlWithCreds =
              '$b2burl&userid=$aUserName&password=$aUserPassword';
          var b2b = await Apis.getB2BList(url: urlWithCreds);
          if (b2b != null) {
            if (b2b.length > 0) {
            b2bListPackages.addAll(b2b[0].package);
            b2bListHotel.addAll(b2b[0].hotel);
            b2bListTransport.addAll(b2b[0].transport);
          }
          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
