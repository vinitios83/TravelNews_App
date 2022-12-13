import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_app/services/remote_api.dart';
import 'package:travel_app/widget/strapbar.dart';

import '../element/loader.dart';
import '../models/newlist.dart';
import '../services/home_ticker_controller.dart';

class MarqueeView extends StatelessWidget {
  final RemoteApi _remoteApi = RemoteApi();
  List<Hotnew> myList = [];
  HomeTickerController tickerController = Get.put(HomeTickerController());
  MarqueeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ArticleList?>(
        future: _remoteApi.getArticlesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return buildLoadingWidget();
          } else {
            myList = snapshot.data!.hotnews;

            tickerController.setB2BTickerMessage(
              myList[0].detail +
                  myList[1].detail +
                  myList[2].detail +
                  myList[3].detail,
            );
            return MyMarquee(
              text: myList[0].detail +
                  myList[1].detail +
                  myList[2].detail +
                  myList[3].detail,
            );
          }
        });
  }
}
