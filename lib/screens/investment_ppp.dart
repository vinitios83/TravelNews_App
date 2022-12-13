import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/global.dart';

import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/utility/marquee.dart';
import 'package:travel_app/widget/my_banners_ads.dart';

import '../element/loader.dart';
import '../services/home_ticker_controller.dart';

import '../services/remote_api.dart';

class InvestmentPPP extends StatefulWidget {
  const InvestmentPPP({
    Key? key,
  }) : super(key: key);

  @override
  State<InvestmentPPP> createState() => _InvestmentPPPState();
}

class _InvestmentPPPState extends State<InvestmentPPP> {
  RxBool isTv = true.obs;
  String marqueecontent =
      "Chhattisgarh, situated in the heart of India is rich in biodiversity and distinct culture. It’s the ninth largest state with a plethora of mythological tales and epics, archaeological and heritage sites dating back to the era of Kalchuris. The unique tribal relevance, has always created a special place for Chhattisgarh, as a religious, cultural and an incredible tourism destination of historical importance. Chhattisgarh is blessed with picturesque natural sites as well such as Buddhist Stupa in Sirpur, Chitrakot fall in Bastar , Tirathgarh Fall, Ganeshji’s Statue in Barsur, the oldest theatre in Ramgarh. There is a lot of scope in tourism in Chhattisgarh from Bastar to Surguja. Chhattisgarh has come up with a new model of developing the economy by investing in projects such as the Ram Van Gaman Path. Do you think it can be a model for other states?";

  String content =
      "Chhattisgarh, situated in the heart of India is rich in biodiversity and distinct culture. It’s the ninth largest state with a plethora of mythological tales and epics, archaeological and heritage sites dating back to the era of Kalchuris. The unique tribal relevance, has always created a special place for Chhattisgarh, as a religious, cultural and an incredible tourism destination of historical importance. Chhattisgarh is blessed with picturesque natural sites as well such as Buddhist Stupa in Sirpur, Chitrakot fall in Bastar , Tirathgarh Fall, Ganeshji’s Statue in Barsur, the oldest theatre in Ramgarh. There is a lot of scope in tourism in Chhattisgarh from Bastar to Surguja. Chhattisgarh has come up with a new model of developing the economy by investing in projects such as the Ram Van Gaman Path. Do you think it can be a model for other states?";
  String bannerimg =
      "https://s3.amazonaws.com/upload.uxpin/files/1263790/1216806/Raipur-9de2fb718ed47c6eb1e3cbf6e019ae5f.jpg";
  final RemoteApi _remoteApi = RemoteApi();
  HomeTickerController tickerController = Get.put(HomeTickerController());
  List maintab = [

  ];
  List othertab = ["Hotels", "MICE", "Adventure Sports", "Infrastructure"];
  int maintabselectedindex = 1;
  int othertabselectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              StateTitle.toString(),
              style: const TextStyle(
                  color: Style.appbarfontcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            const Text(
              '  PPP',
              style: TextStyle(
                  color: Style.appbarpagecolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
        backgroundColor: Style.appbarcolor,
        actions: [
          IconButton(
              onPressed: () {
                isTv(true);
              },
              icon: const Icon(Icons.tv)),
          IconButton(
              onPressed: () {
                isTv(false);
              },
              icon: const Icon(Icons.radio))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(320.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(imageUrl: bannerimg),
              Container(
                color: Style.marqueebackgroundcolor,
                height: 35,
                child: Center(
                  child: Marquee(
                    text: marqueecontent,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Style.marqueefontcolor),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    blankSpace: 20.0,
                    velocity: 30.0,
                    startPadding: 10.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Style.backgroundcolor),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Color textcolor = Style.primaryfontcolor;
                      if (maintabselectedindex == index) {
                        textcolor = Style.selectedmaintabbarcolor;
                      } else {
                        textcolor = Style.primaryfontcolor;
                      }
                      return InkWell(
                          onTap: (() {
                            Get.off(maintab[index]["page"]);
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(maintab[index]["name"].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 18,
                                    fontFamily: 'Economica',
                                    fontWeight: FontWeight.w500)),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const VerticalDivider(
                          thickness: 2,
                          endIndent: 7,
                          indent: 7,
                          color: Style.verticaldividercolor);
                    },
                    itemCount: maintab.length),
              ),
              Container(
                alignment: Alignment.center,
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Style.appbarcolor),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Color textcolor = Style.appbarfontcolor;
                      if (othertabselectedindex == index) {
                        textcolor = Style.selectedbelowtabbarcolor;
                      } else {
                        textcolor = Style.appbarfontcolor;
                      }
                      return InkWell(
                          onTap: (() {}),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(othertab[index].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: textcolor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Economica')),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const VerticalDivider(
                          thickness: 2,
                          endIndent: 7,
                          indent: 7,
                          color: Style.verticaldividercolor);
                    },
                    itemCount: othertab.length),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: _remoteApi.getArticlesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return buildLoadingWidget();
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 32, top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Investment in Hotels',
                          style: TextStyle(
                              fontSize: 18,
                              color: Style.primaryfontcolor,
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                              letterSpacing: 0.2,
                              fontFamily: 'Economica'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          content + content + content,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
