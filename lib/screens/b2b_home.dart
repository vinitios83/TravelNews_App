import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/utility/colors.dart';

import '../../../services/home_ticker_controller.dart';
import '../../models/association_model.dart';

import '../../controller/b2b_controller.dart';
import '../services/associatin_helper.dart';
import '../widget/b2bmarquee.dart';
import '../widget/circular.dart';
import '../widget/common_web_view.dart';
import '../widget/my_banners_ads.dart';
// import '../widget/video_player.dart';
import 'b2blist.dart';

class B2BHome extends StatelessWidget {
  B2BHome({
    Key? key,
    required this.association,
  }) : super(key: key);
  final Association association;
  final B2BController b2bController = Get.put(B2BController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const MyBannerAds(),
      backgroundColor: Style.backgroundcolor,
      appBar: AppBar(
        backgroundColor: Style.appbarcolor,
        title: const Text('B2B',
            style: TextStyle(
                color: Style.appbarfontcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: screenSize.width,
              // child: const VideoApp(),
            ),
            B2BTicker(),
            B2BHomeCards(
              association: association,
            )
          ],
        ),
      ),
    );
  }
}

class B2BTicker extends StatelessWidget {
  B2BTicker({Key? key}) : super(key: key);
  final HomeTickerController tickerController = Get.put(HomeTickerController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return B2BMarquee(text: tickerController.b2bTickerMessage.value);
      },
    );
  }
}

class B2BHomeCards extends StatelessWidget {
  const B2BHomeCards({Key? key, required this.association}) : super(key: key);
  final Association association;
  @override
  Widget build(BuildContext context) {
    int aID = int.parse(association.id);
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Style.othertabbarcolor),
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Get.to(() => CircularUpdateScreen(aId: aID, index: 0)),
             child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Info',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 2,
            endIndent: 7,
            indent: 7,
            color: Style.othertabbarcolor,
          ),
          InkWell(
            onTap: () => Get.to(() => CircularUpdateScreen(aId: aID, index: 1)),
            
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Updates',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const VerticalDivider(
              thickness: 2,
              endIndent: 7,
              indent: 7,
              color: Style.othertabbarcolor),
          InkWell(
            onTap: () => Get.to(
              () => B2BList(
                association: association,
              ),
            ),
            
             child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'B2B',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          const VerticalDivider(
              thickness: 2,
              endIndent: 7,
              indent: 7,
              color: Style.othertabbarcolor),
          InkWell(
            onTap: () => Get.to(
              () => CommonWebView(
                url: AssociationHelper.aboutUS + association.id,
                association: association,
              ),
            ),
             child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'About Us',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
