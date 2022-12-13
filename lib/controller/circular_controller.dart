import 'package:get/get.dart';

import '../models/circular.dart';
import '../services/associations_api.dart';


class CircularController extends GetxController {
  var isLoading = true.obs;

  List<Circular> circular = <Circular>[].obs;
  List<Circular> updates = <Circular>[].obs;

  Future<void> fetchCircular({
    required String aId,
  }) async {
    circular.clear();
    updates.clear();
    try {
      if (circular.isEmpty || updates.isEmpty) {
        isLoading(true);
        circular.clear();
        updates.clear();
      }
      var myCircular = await Apis.getCirculars(assId: aId);

      if (myCircular != null) {
        circular.addAll(myCircular.circular);
        updates.addAll(myCircular.updates);
      }
    } finally {
      isLoading(false);
    }
  }
}
