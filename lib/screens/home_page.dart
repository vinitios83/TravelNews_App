import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/screens/b2b.dart';
import 'package:travel_app/screens/interviews.dart';
import 'package:travel_app/screens/news.dart';
import 'package:travel_app/screens/ppp_home.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/widget/app_drawer.dart';
import 'package:travel_app/widget/my_banners_ads.dart';

import '../element/loader.dart';
import '../models/newlist.dart';
import '../services/asset_helper.dart';
import '../services/home_ticker_controller.dart';
import '../utility/constant.dart';

import '../widget/home_news.dart';
import '../widget/live_tv.dart';
import '../widget/radio_page.dart';
import '../widget/strapbar.dart';
import '../services/remote_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxBool isTv = true.obs;

  List<Hotnew> myList = [];
  final RemoteApi _remoteApi = RemoteApi();
  HomeTickerController tickerController = Get.put(HomeTickerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      drawer: const MyDrawer(),
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        title: const Text(
          'Travel Business',
          style: TextStyle(
              color: Style.appbarfontcolor,
              fontWeight: FontWeight.bold,
              fontSize: 30),
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
            preferredSize: const Size.fromHeight(230.0),
            child: Obx((() {
              if (isTv.value == true) {
                return Column(
                  children: [
                    Container(
                      height: 1.5,
                      color: Style.dividercolor,
                    ),
                    const LiveTvPage(url: AssetsHelper.liveTVUrl),
                  ],
                );
              } else {
                return Column(
                  children: const [
                    Divider(
                      color: Style.dividercolor,
                    ),
                    MyAudioPage(
                      url: AppConstants.liveRadio,
                      key: ValueKey(AppConstants.liveRadio),
                      isRadio: true,
                    ),
                  ],
                );
              }
            }))),
      ),
      body: FutureBuilder<ArticleList?>(
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
            return Column(
              children: [
                MyMarquee(
                  text: myList[0].detail +
                      myList[1].detail +
                      myList[2].detail +
                      myList[3].detail,
                ),
                Container(
                  height: 40,
                  decoration:
                      const BoxDecoration(color: Style.othertabbarcolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const NewsList());
                        },
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'News',
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
                        onTap: () {
                          Get.to(const YouTubeListPage());
                        },
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Views/Interviews',
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
                        onTap: () {
                          Get.to(const AssociationPage());
                        },
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
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
                        color: Style.othertabbarcolor,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const PPPHome());
                        },
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'PPP',
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
                        onTap: () {
                          // Get.to(const PPPHome());
                        },
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Campus',
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyList(
                      mylist: myList,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({
    Key? key,
    required this.mylist,
  }) : super(key: key);

  final List<Hotnew> mylist;

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int adIndex = -1;

  @override
  Widget build(BuildContext context) {
    return
        // color: AppTheme.kPrimaryColor,
        ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      cacheExtent: widget.mylist.length.toDouble(),
      itemCount: widget.mylist.length,
      itemBuilder: (context, index) {
        return ArticleTile(
          list: widget.mylist,
          index: index,
        );
      },
    );
  }
}
