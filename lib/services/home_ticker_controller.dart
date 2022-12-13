import 'package:get/get.dart';

class HomeTickerController extends GetxController {
  var isLoading = true.obs;

  RxString b2bTickerMessage = ' '.obs;

  void setB2BTickerMessage(String ticker) {
    b2bTickerMessage.value = ticker;
  }
}
