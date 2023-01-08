import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/models/CampusDataModel.dart';
import '../services/remote_api.dart';
import '../utility/constant.dart';
import 'package:get/get.dart';
import 'package:travel_app/widget/live_tv.dart';
import 'package:travel_app/screens/YouTubePlayerPage.dart';
import '../widget/my_banners_ads.dart';
import 'package:travel_app/widget/HtmlWidget.dart';


class BeDestinationPage extends StatefulWidget {
  const BeDestinationPage({Key? key}) : super(key: key);

  @override
  State<BeDestinationPage> createState() => _BeDestinationPageState();
}

class _BeDestinationPageState extends State<BeDestinationPage>
    with SingleTickerProviderStateMixin {
  final RemoteApi _remoteApi = RemoteApi();
  var currentPage = 0;
  var subPage = 0;
  var subsubPage = 0;
  List<CampusCategory> campusCategoryList = [];
  List<CampusCategory> subCampusCategoryList = [];
  List<CampusCategory> subsubCategoryList = [];
  List<CampusCategory> videoCategoryList = [];
  var isCallingAPI = true;
  @override
  void initState() {
    super.initState();
    fetchDestinationCategoryList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchDestinationCategoryList() async {
    await RemoteApi().getDestinationCategoryList().then((value) => {
          campusCategoryList = value?.campusCategoryList ?? [],
          if (campusCategoryList.length == 0)
            {
              this.setState(() {
                isCallingAPI = false;
              })
            }
          else
            {fetchSubDestinationCategoryList()}
        });
  }

  fetchSubDestinationCategoryList() async {
    isCallingAPI = true;
    await RemoteApi()
        .getSubDestinationCategory(campusCategoryList[currentPage].id)
        .then((value) => {
              subCampusCategoryList = value?.campusCategoryList ?? [],
              if (subCampusCategoryList.length == 0)
                {
                  this.setState(() {
                    isCallingAPI = false;
                  })
                }
              else
                {fetchSubSubDestinationList()}
            });
  }

  fetchSubSubDestinationList() async {
    isCallingAPI = true;
    await RemoteApi()
        .getSubsubDestinationList(campusCategoryList[currentPage].id,
            subCampusCategoryList[subPage].id)
        .then((value) => {
              subsubCategoryList = value?.campusCategoryList ?? [],
              if (subsubCategoryList.length == 0)
                {
                  this.setState(() {
                    isCallingAPI = false;
                  })
                }
              else
                {fetchVideoDestinationList()}
            });
  }

  fetchVideoDestinationList() async {
    isCallingAPI = true;
    await RemoteApi()
        .getVideoDestinationList(
            campusCategoryList[currentPage].id,
            subCampusCategoryList[subPage].id,
            subsubCategoryList[subsubPage].id)
        .then((value) => {
              videoCategoryList = value?.campusCategoryList ?? [],
              this.setState(() {
                isCallingAPI = false;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.backgroundcolor,
        appBar: AppBar(
          backgroundColor: Style.appbarcolor,
          automaticallyImplyLeading: true,
          title: Row(
            children: const [
              Text('Be Destination',
                  style: TextStyle(
                      color: Style.appbarfontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(width: 8),
              Text(
                'CAMPUS',
                style: TextStyle(
                    color: Style.appbarpagecolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyBannerAds(),
        body: (campusCategoryList.length == 0)
            ? nullui()
            : Column(children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      const BoxDecoration(color: Style.headerYellowcolor),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          Color textcolor = Style.primaryfontcolor;
                          return Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: InkWell(
                              onTap: (() {
                                setState(() {
                                  currentPage = index;
                                  subPage = 0;
                                  fetchSubDestinationCategoryList();
                                });
                              }),
                              child: Container(
                                decoration: (currentPage == index)
                                    ? BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                            color: Style.appbarcolor,
                                          )
                                        ],
                                      )
                                    : BoxDecoration(),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Text(
                                      campusCategoryList[index].videocat ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: textcolor,
                                          fontSize: 16,
                                          letterSpacing: 0.2,
                                          fontFamily: 'Economica Bold',
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const VerticalDivider(
                            width: 8,
                          );
                        },
                        itemCount: campusCategoryList.length),
                  ),
                ),
                (subCampusCategoryList.length == 0)
                    ? nullui()
                    : Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            const BoxDecoration(color: Style.headerYellowcolor),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Color textcolor = Style.primaryfontcolor;
                                return Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        subPage = index;
                                        subsubPage = 0;
                                        fetchSubSubDestinationList();
                                      });
                                    }),
                                    child: Container(
                                      decoration: (subPage == index)
                                          ? BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 0.0,
                                                  spreadRadius: 0.0,
                                                  color: Style.appbarcolor,
                                                )
                                              ],
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text(
                                            subCampusCategoryList[index]
                                                    .videosubcat ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: textcolor,
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                fontFamily: 'Economica Bold',
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const VerticalDivider(
                                  width: 8,
                                );
                              },
                              itemCount: subCampusCategoryList.length),
                        ),
                      ),
                (subsubCategoryList.length == 0)
                    ? nullui()
                    : Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            const BoxDecoration(color: Style.headerYellowcolor),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Color textcolor = Style.primaryfontcolor;
                                return Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: InkWell(
                                    onTap: (() {
                                      setState(() {
                                        subsubPage = index;
                                        fetchVideoDestinationList();
                                      });
                                    }),
                                    child: Container(
                                      decoration: (subsubPage == index)
                                          ? BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 0.0,
                                                  spreadRadius: 0.0,
                                                  color: Style.appbarcolor,
                                                )
                                              ],
                                            )
                                          : BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text(
                                            subsubCategoryList[index]
                                                    .subsubcat ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: textcolor,
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                fontFamily: 'Economica Bold',
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const VerticalDivider(
                                  width: 8,
                                );
                              },
                              itemCount: subsubCategoryList.length),
                        ),
                      ),
                SizedBox(
                  height: 10,
                ),
                (videoCategoryList.length == 0)
                    ? nullui()
                    : Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height - 330,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                
                                return Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                        width:
                                            MediaQuery.of(context).size.width - 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                              videoCategoryList[index].place ?? "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Style.primaryfontcolor,
                                                  fontFamily:
                                                      'Calibri Regular'),
                                            ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Flexible(
                                              child: HtmlView(strHtml: videoCategoryList[index].detail ?? "",)
                                            ),
                                          ],
                                        ),
                                      ),
                                )),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const VerticalDivider(
                                  width: 8,
                                );
                              },
                              itemCount: subCampusCategoryList.length),
                        ),
                      ),
              ]));
  }

  Widget nullui() {
    if (isCallingAPI == true) {
      return buildLoadingWidget();
    } else {
      return const Center(
        child: Text(
          "Nothing to show",
          style: TextStyle(
              fontSize: 18,
              color: Style.primaryfontcolor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Economica'),
        ),
      );
    }
  }
}
