import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/screens/b2b.dart';
import 'package:travel_app/screens/interviews.dart';
import 'package:travel_app/screens/news.dart';
import 'package:travel_app/screens/ppp_home.dart';
import 'package:travel_app/screens/Campus_Page.dart';
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
  bool isPlayTV = false;
  List<Hotnew> myList = [];
  final RemoteApi _remoteApi = RemoteApi();
  HomeTickerController tickerController = Get.put(HomeTickerController());

void _handlePushFromList(bool newValue) {
    setState(() {
      isPlayTV = false;
    });
  }

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
                if (this.isPlayTV == false) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        this.isPlayTV = true;
                      });
                    },
                    child: SizedBox(
                        height: 230,
                        child: Stack(
                          children: [
                            const Image(image: AssetImage('assets/tv.jpeg')),
                            Positioned(
                                top: MediaQuery.of(context).size.height * 0.1,
                                right: MediaQuery.of(context).size.width * 0.45,
                                child: const Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: Colors.white,
                                ))
                          ],
                        )),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        height: 1.5,
                        color: Style.dividercolor,
                      ),
                      const LiveTvPage(url: AssetsHelper.liveTVUrl),
                    ],
                  );
                }
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
                  height: 50,
                  decoration:
                      const BoxDecoration(color: Style.headerYellowcolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isPlayTV = false;
                          });
                          Get.to(const NewsList());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'News',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Style.headerYellowcolor,
                        width: 5.0,
                          ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isPlayTV = false;
                          });
                          Get.to(const YouTubeListPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'Views/Interviews',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Style.headerYellowcolor,
                          width: 5.0,),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isPlayTV = false;
                          });
                          Get.to(const AssociationPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'B2B',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Style.headerYellowcolor,
                        width: 5.0
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isPlayTV = false;
                          });
                          Get.to(const PPPHome());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'PPP',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: Style.headerYellowcolor,
                        width: 5.0
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isPlayTV = false;
                          });
                          Get.to(const CapmusPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Colors.white,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            child: Text(
                              'Campus',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 18,
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
                      isPlayTV: true,
                      onChanged: _handlePushFromList,
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
    required this.onChanged,
    required this.isPlayTV,
  }) : super(key: key);

  final List<Hotnew> mylist;
  final ValueChanged<bool> onChanged;
  final bool isPlayTV;

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int adIndex = -1;
  void _handlePushFromList(bool newValue) {
    widget.onChanged(false);
  }
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
          onChanged: _handlePushFromList,
          isPlayTV: widget.isPlayTV,
        );
      },
    );
  }
}
