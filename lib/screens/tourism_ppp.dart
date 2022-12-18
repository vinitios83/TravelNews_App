import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

import 'package:travel_app/models/Text_PPPData.dart';
import 'package:travel_app/models/checknulData.dart';
import 'package:travel_app/models/SliderLinkData.dart';
import 'package:travel_app/models/tourism_PPP.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel_app/screens/ppp_home.dart';
import 'package:travel_app/widget/pdfViewer.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:get/get.dart';
import 'package:travel_app/widget/live_tv.dart';
import 'package:travel_app/widget/my_banners_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../element/loader.dart';
import '../services/home_ticker_controller.dart';

import '../services/remote_api.dart';

class TourismPPP extends StatefulWidget {
  final String id;
  const TourismPPP({Key? key, required this.id}) : super(key: key);

  @override
  State<TourismPPP> createState() => _TourismPPPState();
}

class _TourismPPPState extends State<TourismPPP> {
  RxBool isTv = true.obs;

  String bannerimg =
      "https://s3.amazonaws.com/upload.uxpin/files/1263790/1216806/Raipur-9de2fb718ed47c6eb1e3cbf6e019ae5f.jpg";
  List<Map<String, dynamic>> maintab = [];
  List<Map<String, dynamic>> othertab = [];
  int maintabselectedindex = 0;
  int othertabselectedindex = 0;
  String selectedcategoary = "";
  String selectedsubcategoary = "";
  TourismPpp? bardata;
  bool isloading = true;
  Widget ui = const Center(
    child: Text(
      "Nothing to show",
      style: TextStyle(
          fontSize: 18,
          color: Style.primaryfontcolor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Economica'),
    ),
  );
  HomeTickerController tickerController = Get.put(HomeTickerController());
  getdata() async {
    bardata = await RemoteApi().getTourismPPPHome(widget.id);
    settopbar();
  }

  settopbar() {
    maintab.clear();
    bardata!.tourismName[0].sectionCate.forEach((element) {
      maintab.add({"value": element.category, "id": element.categoryid});
    });

    setState(() {
      setotherbar();
    });
  }

  setotherbar() {
    othertab.clear();
    if (bardata!.tourismName[0].sectionCate.isNotEmpty) {
      bardata!.tourismName[0].sectionCate[maintabselectedindex].sectionSubCate
          .forEach((element) {
        othertab.add(
            {"value": element.subcategory, "subid": element.subcategoryid});
      });
      setState(() {
        setcontent();
      });
    }
  }

  setcontent() async {
    setState(() {
      isloading = true;
    });
    var data = await RemoteApi().getTourismPPPData(
      maintab[maintabselectedindex]["id"],
      othertab[othertabselectedindex]["subid"],
    );
    CheckNullData check = CheckNullData.fromJson(data);
    if (check.sectionContent.isNotEmpty) {
      if (data[0]["SectionContent"][0]["contenttype"] == "Text") {
        TextPppData text = TextPppData.fromJson(data);
        setState(() {
          ui = textui(text);
          bannerimg = text.sectionContent[0].img;
        });
      } else if (data[0]["SectionContent"][0]["contenttype"] == "Image") {
        SliderData img = SliderData.fromJson(data);
        ui = imgui(img);
      } else if (data[0]["SectionContent"][0]["contenttype"] == "PDF") {
        SliderData pdf = SliderData.fromJson(data);

        ui = pdfui(pdf);
      } else if (data[0]["SectionContent"][0]["contenttype"] == "Video") {
        SliderData video = SliderData.fromJson(data);

        ui = videoui(video);
      }
    } else {
      setState(() {
        ui = nullui();
      });
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.backgroundcolor,
        bottomNavigationBar: const MyBannerAds(),
        appBar: AppBar(
          title: SizedBox(
            // width: MediaQuery.of(context).size.width * 0.95,
            child: Row(
              children: [
                const Text(
                  'Travel Business',
                  style: TextStyle(
                      color: Style.appbarfontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Spacer(),
                const Text(
                  'PPP',
                  style: TextStyle(
                      color: Style.appbarpagecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Spacer(),
                const Text(
                  'Directory',
                  style: TextStyle(
                      color: Style.appbarfontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _launchUrl(
                        "https://travelworldonline.in/twoapp/StakeholderRegistration/StakeholderRegistration.aspx?travelNI_id=1");
                  },
                  child: const Text(
                    'Stake holder\n Registration',
                    style: TextStyle(
                        color: Style.appbarfontcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.off(const PPPHome());
              },
              icon: const Icon(Icons.arrow_back)),
          leadingWidth: 30,
          backgroundColor: Style.appbarcolor,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(300.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl: bannerimg,
                      fit: BoxFit.fill,
                      height: 300,
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration:
                              const BoxDecoration(color: Style.backgroundcolor),
                          child: Padding(padding: EdgeInsets.all(5),
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Color textcolor = Style.primaryfontcolor;
                                return Padding(padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: InkWell(
                                  onTap: (() {
                                    setState(() {
                                      maintabselectedindex = index;
                                      othertabselectedindex = 0;
                                      setotherbar();
                                    });
                                  }),
                                  child: Container(
                                    decoration: (maintabselectedindex == index)
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
                                          maintab[index]["value"].toString(),
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
                              itemCount: maintab.length),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Style.marqueebackgroundcolor),
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                Color textcolor = Style.primaryfontcolor;
                                if (othertabselectedindex == index) {
                                  textcolor = Style.primaryfontcolor;
                                } else {
                                  textcolor = Style.appbarfontcolor;
                                }
                              return Padding(padding: EdgeInsets.only(top: 5,bottom: 5),
                                child: InkWell(
                                  onTap: (() {
                                    setState(() {
                                        othertabselectedindex = index;
                                        setcontent();
                                      });
                                    }),
                                  child: Container(
                                    decoration: (othertabselectedindex == index)
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
                                          othertab[index]["value"].toString(),
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
                              itemCount: othertab.length),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: isloading ? buildLoadingWidget() : ui);
  }

  Widget nullui() {
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

  Widget textui(TextPppData data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 35, right: 32, top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.sectionContent[0].title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Style.primaryfontcolor,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Economica'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data.sectionContent[0].sectiondetails,
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

  Widget videoui(SliderData data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: data.sectionContent[0].items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(LiveTvPage(
                            //     url:
                            //         "http://techslides.com/demos/sample-videos/small.mp4"));
                            print("Video URL: " + i["Url"].toString());
                            Get.to(LiveTvPage(url: i["Url"].toString()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Stack(
                              children: [
                                Center(
                                  child: CachedNetworkImage(
                                      imageUrl: i["Imageurl"].toString()),
                                ),
                                Center(
                                    child: Image.asset("assets/yt_news.png")),
                              ],
                            ),
                          ),
                        )),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget customWidget(String img) => FullScreenWidget(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: img.toString(),
          placeholder: (context, url) =>
              Image.asset("assets/app_icon_square.png"),
        ),
      );
  Widget imgui(SliderData data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: data.sectionContent[0].items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    //
                    child: customWidget(i["Url"].toString()),
                  );
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget pdfui(SliderData data) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
            items: data.sectionContent[0].items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(PDFViewerCachedFromUrl(
                            url: i["Url"].toString(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CachedNetworkImage(
                              imageUrl: i["Imageurl"].toString()),
                        ),
                      ));
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
