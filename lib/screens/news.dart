import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/screens/home_page.dart';
import 'package:travel_app/utility/colors.dart';

import '../element/loader.dart';
import '../models/newlist.dart';
import '../services/home_ticker_controller.dart';
import '../services/remote_api.dart';

import '../widget/my_banners_ads.dart';
import '../widget/strapbar.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  HomeTickerController tickerController = Get.put(HomeTickerController());
  final RemoteApi _remoteApi = RemoteApi();
  List<Hotnew> airlines = [];
  // List<Hotnew> destinations = [];
  List<Hotnew> hotels = [];
  List<Hotnew> miscellaneous = [];
  List<Hotnew> tourism = [];
  // List<Hotnew> tour = [];
  List<Hotnew> travel = [];
  List<Hotnew> myList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const MyBannerAds(),
      body: FutureBuilder<ArticleList?>(
        future: _remoteApi.getArticlesList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return buildLoadingWidget();
          } else {
            myList = snapshot.data!.hotnews;
            airlines = snapshot.data!.videodetail
                .where((news) => news.videocate == Videocate.AIRLINES)
                .toList();
            // destinations = snapshot.data!.videodetail
            //     .where((news) => news.videocate == Videocate.DESTINATIONS)
            //     .toList();
            hotels = snapshot.data!.videodetail
                .where((news) => news.videocate == Videocate.HOTELS)
                .toList();
            miscellaneous = snapshot.data!.videodetail
                .where((news) => news.videocate == Videocate.MISCELLANEOUS)
                .toList();
            tourism = snapshot.data!.videodetail
                .where((news) => news.videocate == Videocate.TOURISM_BOARDS)
                .toList();
            // tour = snapshot.data!.videodetail
            //     .where((news) => news.videocate == Videocate.TOUR_OPERATORS)
            //     .toList();
            travel = snapshot.data!.videodetail
                .where((news) => news.videocate == Videocate.TRAVEL_AGENTS)
                .toList();
            tickerController.setB2BTickerMessage(
              myList[0].detail +
                  myList[1].detail +
                  myList[2].detail +
                  myList[3].detail,
            );
            return Scaffold(
              backgroundColor: Style.backgroundcolor,
              appBar: AppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.5),
                  child: Container(height: 1.5, color: Style.dividercolor),
                ),
                automaticallyImplyLeading: true,
                backgroundColor: Style.appbarcolor,
                title: Row(
                  children: const [
                    Text('Travel Business',
                        style: TextStyle(
                            color: Style.appbarfontcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    SizedBox(width: 8),
                    Text(
                      'NEWS',
                      style: TextStyle(
                          color: Style.appbarpagecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                ),
                elevation: 0.0,
              ),
              body: Column(
                children: [
                  MyMarquee(
                    text: myList[0].detail +
                        myList[1].detail +
                        myList[2].detail +
                        myList[3].detail,
                  ),
                  MyHomePageTabBar(
                    airlines: airlines,
                    hotels: hotels,
                    tourism: tourism,
                    travel: travel,
                    miscellaneous: miscellaneous,
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

class MyHomePageTabBar extends StatefulWidget {
  MyHomePageTabBar({
    Key? key,

    // required this.myList,
    required this.hotels,
    required this.travel,
    required this.airlines,
    // required this.destinations,

    required this.tourism,
    // required this.tour,

    required this.miscellaneous,
  }) : super(key: key);
// final List<Hotnew> myList;
  final List<Hotnew> hotels;
  final List<Hotnew> travel;
  final List<Hotnew> airlines;
  // final List<Hotnew> destinations;

  final List<Hotnew> tourism;
  // final List<Hotnew> tour;

  final List<Hotnew> miscellaneous;
  @override
  _MyHomePageTabBarState createState() => _MyHomePageTabBarState();
}

class _MyHomePageTabBarState extends State<MyHomePageTabBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var currentPage = 0;
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 46,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Style.othertabbarcolor),
            child: Padding(padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (() {
                    controller.animateToPage(0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    setState(() {
                      this.currentPage = 0;
                    });

                  }),
                  child: Container(
                    decoration: (this.currentPage == 0) ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: Style.appbarcolor,
                        )
                      ],
                    ) : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Hotels',
                        style: TextStyle(
                            color: Style.tabbarfontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                
                InkWell(
                  onTap: (() {
                    controller.animateToPage(1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    setState(() {
                      this.currentPage = 1;
                    });
                  }),
                  child: Container(
                    decoration: (this.currentPage == 1) ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: Style.appbarcolor,
                        )
                      ],
                    ) : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Associations',
                        style: TextStyle(
                            color: Style.tabbarfontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              
                InkWell(
                  onTap: (() {
                    controller.animateToPage(2,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    setState(() {
                      this.currentPage = 2;
                    });
                  }),
                  child: Container(
                    decoration: (this.currentPage == 2) ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: Style.appbarcolor,
                        )
                      ],
                    ) : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Airlines',
                        style: TextStyle(
                            color: Style.tabbarfontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                
                InkWell(
                  onTap: (() {
                    controller.animateToPage(3,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    setState(() {
                      this.currentPage = 3;
                    });
                  }),
                  child: Container(
                    decoration: (this.currentPage == 3) ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: Style.appbarcolor,
                        )
                      ],
                    ) : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Tourism Boards',
                        style: TextStyle(
                            color: Style.tabbarfontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              
                InkWell(
                  onTap: (() {
                    controller.animateToPage(4,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    setState(() {
                      this.currentPage = 4;
                    });
                  }),
                  child: Container(
                    decoration: (this.currentPage == 4) ? BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          color: Style.appbarcolor,
                        )
                      ],
                    ) : BoxDecoration(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Text(
                        'Others',
                        style: TextStyle(
                            color: Style.tabbarfontcolor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
            ),
          ),
          const Divider(
            height: 8,
        
                  color: Colors.white,
                ),
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                MyList(mylist: widget.hotels),
                MyList(mylist: widget.travel),
                MyList(
                  mylist: widget.airlines,
                ),
                MyList(mylist: widget.tourism),
                MyList(mylist: widget.miscellaneous),
              ],
              onPageChanged: (value) {
                setState(() {
                  this.currentPage = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
