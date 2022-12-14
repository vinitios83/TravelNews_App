import 'package:get/get.dart';

import '../models/association_model.dart';
import '../services/associations_api.dart';






class AssociationController extends GetxController {
  var isLoading = true.obs;
  var associationList = <Association>[].obs;
  RxString passwordMessage = ''.obs;
  RxString selectedAType = 'National'.obs;
  RxString appBarTitle = 'ASSOCIATIONS'.obs;
  Association? b2bAssociation;

  @override
  void onInit() {
    fetchAssoctionList();
    super.onInit();
  }

  Future<void> fetchAssoctionList() async {
    associationList.clear();
    try {
      if (associationList.isEmpty) {
        isLoading(true);
        associationList.clear();
      }
      var posts = await Apis.getAssociationList(
        time: DateTime.now().toIso8601String(),
      );
      if (posts != null) {
        associationList.addAll(posts);
      }
      b2bAssociation = associationList.firstWhere((element) => element.name == 'FAITH');
      associationList.removeWhere((element) => element.name == 'FAITH');
    } finally {
      isLoading(false);
    }
  }
}
