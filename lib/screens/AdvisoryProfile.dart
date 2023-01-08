import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

class AdvisoryProfilePage extends StatefulWidget {
  const AdvisoryProfilePage({Key? key}) : super(key: key);

  @override
  State<AdvisoryProfilePage> createState() => _AdvisoryProfilePageState();
}

class _AdvisoryProfilePageState extends State<AdvisoryProfilePage>
    with SingleTickerProviderStateMixin {
  final RemoteApi _remoteApi = RemoteApi();
  List<AdvisoryProfile> profileList = [];
  var isCallingAPI = true;
  
  @override
  void initState() {
    super.initState();
    fetchProfileList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchProfileList() async {
    await RemoteApi().getProfileList().then((value) => {
          profileList = value?.advisoryProfileList ?? [],
          
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
              Text('Advisory Board',
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
        body: Padding(padding: EdgeInsets.all(10),
          child: (profileList.length == 0)
                    ? nullui()
                    : Expanded(
                        child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemCount: this.profileList.length,
                        itemBuilder: (context, index) {
                          String imageUrl = this.profileList[index].image ?? "";
                          String title = this.profileList[index].name ?? "";
                          String detail = this.profileList[index].bio ?? "";
                          return GestureDetector(
      onTap: (() {
        
      }),
      child: Padding(padding: EdgeInsets.only(bottom: 8),
      child: Container(
          height: 110,
          child: Card(
            elevation: 1.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
            child: Padding(padding: EdgeInsets.all(8),
              child: Row(
              children: [
                Expanded(
                  flex: 33,
                  child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                height: 80,
                                width: 120,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Image.asset(
                                    AppConstants.fallBackLogo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                errorWidget: (context, url, _) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  width: 120,
                                  child: Image.asset(
                                    AppConstants.fallBackLogo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                ),
                VerticalDivider(
                  color: Colors.white,
                  width: 8.0,
                ),
                Expanded(
                  flex: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 25,
                        child: Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Style.primaryfontcolor,
                                      fontFamily: 'Calibri Regular'),
                                ),
                              
                      ),
                      
                      Expanded(flex: 70, child: Text(
                          detail,
                          maxLines: 4,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                        ),),
                    ],
                  ),
                ),        
              ],
            ),
            )
          ),
        ),
      )
    );
                        },
                      )),

          )
        );
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

/*
(campusCategoryList.length == 0)
            ? nullui()
            : Column(children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      const BoxDecoration(color: Style.othertabbarcolor),
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
                                  fetchSubCategoryList();
                                });
                              }),
                              child: Container(
                                decoration: (currentPage == index)
                                    ? BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            spreadRadius: 1.0,
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
                            const BoxDecoration(color: Style.othertabbarcolor),
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
                                        fetchCategoryVideoList();
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
                                                  blurRadius: 4.0,
                                                  spreadRadius: 1.0,
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
                      SizedBox(
                        height: 10,
                      ),
                (videoList.length == 0)
                    ? nullui()
                    : Expanded(
                        child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 1,
                          );
                        },
                        itemCount: this.videoList.length,
                        itemBuilder: (context, index) {
                          String imageUrl = this.videoList[index].image ?? "";
                          String title = this.videoList[index].heading ?? "";
                          String detail = this.videoList[index].detail ?? "";
                          String videoUrl = this.videoList[index].video ?? "";
                          return GestureDetector(
                            onTap: () {
                              Get.to(YouTubePlayerPage(
                                videoDetail: videoList[index],
                              ));
                              // Get.to(LiveTvPage(url: videoUrl));
                            },
                            child: Card(
                                  child: Column(
                                    children: [
                                      
                                      Row(
                                        children: [
                                          SizedBox(
                                        width: 5,
                                      ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5, bottom: 3),
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrl,
                                              height: 70,
                                              width: 120,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Image.asset(
                                                  AppConstants.fallBackLogo,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              errorWidget: (context, url, _) =>
                                                  SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03,
                                                width: 120,
                                                child: Image.asset(
                                                  AppConstants.fallBackLogo,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width - (175),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              
                                              children: [
                                                Text(
                                                  title,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Style
                                                          .primaryfontcolor,
                                                      fontFamily:
                                                          'Calibri Regular'),
                                                ),
                                                Text(
                                                  detail,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color.fromARGB(255, 72, 72, 72),
                                                      fontFamily:
                                                          'Calibri Regular'),
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        color: Style.dividercolor,
                                      )
                                    ],
                                  ),
                                ),
                          );
                        },
                      )),
              ]))
*/