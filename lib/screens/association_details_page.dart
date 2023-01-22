import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';

import '../../controller/association_detail_controller.dart';
import '../../models/association_model.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';
import '../version/version_contoller.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../widget/b2bmarquee.dart';
import '../widget/circular.dart';
import '../widget/common_web_view.dart';
import '../widget/live_tv.dart';
import '../widget/my_banners_ads.dart';
import 'b2blist.dart';
import 'member_list.dart';

class AssociationDetailPage extends StatefulWidget {
  const AssociationDetailPage({
    Key? key,
    required this.association,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final Association association;
  final String userName;
  final String password;

  @override
  State<AssociationDetailPage> createState() => _AssociationDetailPageState();
}

class _AssociationDetailPageState extends State<AssociationDetailPage> {
  final AssociationDetailController b2bController =
      Get.put(AssociationDetailController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    b2bController.fetchAssociationDeals(
      aId: widget.association.id,
      aName: widget.association.name,
      aUserName: widget.userName,
      aUserPassword: widget.password,
    );
    var url = AssociationHelper.aboutUS + widget.association.id;
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.5),
            child: Container(
              height: 1.5,
              color: Style.dividercolor,
            )),
        backgroundColor: Style.appbarcolor,
        title: Text(widget.association.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          (isLoading)
              ? SizedBox(
                  height: 20,
                  width: 40,
                  child: Center(child: buildLoadingWidget()),
                )
              : GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await Apis.getLiveTVUrl(org: widget.association.name)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      if ('$value'.startsWith('http')) {
                        Get.to(
                          () => LiveTvPage(url: '$value'),
                        );
                      } else {
                        Get.defaultDialog(
                          title: '$value',
                          content: const Text(''),
                          // backgroundColor: Colors.amber,
                          // onConfirm: () => Get.back(),
                          // textConfirm: 'Ok',
                        );
                      }
                    });
                  },
                  child: const SizedBox(
                    height: 35,
                    width: 60,
                    // child: Image.asset(
                    //   AssetsHelper.liveButtonImage,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                ),
          const WidthBox(20),
        ],
      ),
      body: Obx(
        () {
          if (b2bController.isLoading.value) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: buildLoadingWidget()),
            );
          } else {
            if (b2bController.auth.value) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        child: const Header()),
                    const Divider(
                      height: 1.5,
                      color: Style.dividercolor,
                    ),
                    B2BTicker(),
                    const Divider(
                      height: 1.5,
                      color: Style.dividercolor,
                    ),
                    B2BHomeCards(
                      association: widget.association,
                      password: widget.password,
                      userName: widget.userName,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Authentication failed\nPlease sign out and relogin',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class B2BTicker extends StatelessWidget {
  B2BTicker({Key? key}) : super(key: key);
  final AssociationDetailController b2bController =
      Get.put(AssociationDetailController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (b2bController.isLoading.value) {
          return SizedBox(
            height: 30,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: buildLoadingWidget()),
            ),
          );
        } else {
          if (b2bController.ticker.isEmpty) {
            return const SizedBox.shrink();
          } else if (b2bController.ticker.first.tickertext.isEmptyOrNull) {
            return const SizedBox.shrink();
          } else {
            return B2BMarquee(text: b2bController.ticker.first.tickertext);
          }
        }
      },
    );
  }
}

class B2BHomeCards extends StatelessWidget {
  const B2BHomeCards({
    Key? key,
    required this.association,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final Association association;
  final String userName;
  final String password;
  @override
  Widget build(BuildContext context) {
    int aID = int.parse(association.id);
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        decoration: const BoxDecoration(color:Colors.white),
        height: screenSize.height - 420,
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: InkWell(
            onTap: () => Get.to(() => CircularUpdateScreen(aId: aID, index: 0)),
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
              child: Center(
                // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    Image.asset("assets/circulars.png",height: 60,width: 60),
                    Text(
                  'Circular',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                  ],
                ),
              ),
            ),
          ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: InkWell(
            onTap: () => Get.to(() => CircularUpdateScreen(aId: aID, index: 1)),
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
              child: Center(
                // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    Image.asset("assets/updates.png",height: 60,width: 60),
                    Text(
                  'Updates',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                  ],
                ),
              ),
            ),
          ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: InkWell(
            onTap: () => Get.to(
              () => B2BList(
                association: association,
                userid: userName,
                password: password,
              ),
            ),
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
              child: Center(
                // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    Image.asset("assets/b2b.png",height: 60,width: 60),
                    Text(
                  'B2B',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                  ],
                ),
              ),
            ),
          ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: InkWell(
            onTap: () => Get.to(
              () => MemberListPage(
                association: association,
                userName: userName,
                password: password,
              ),
            ),
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
              child: Center(
                // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    Image.asset("assets/directory.png",height: 60,width: 60),
                    Text(
                  'Directory',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                  ],
                ),
              ),
            ),
          ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: InkWell(
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
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
                              )
                            ],
                          ),
              child: Center(
                // padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  children: [
                    Image.asset("assets/about_iato.png",height: 60,width: 60),
                    Text(
                  'About US',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                  ],
                ),
              ),
            ),
          ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: const Text(''),
            ),
          ],
        ));
  }
}

class Header extends StatefulWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  VersionController versionController = Get.put(VersionController());
  bool isInitialised = false;

  late YoutubePlayerController controller;

  @override
  void initState() {
    playDefaultVideo();
    super.initState();
  }

  Future<void> playDefaultVideo() async {
    await Future.delayed(const Duration(seconds: 5));
    controller = YoutubePlayerController.fromVideoId(
        videoId: versionController.youtubedefault.value,
        params: const YoutubePlayerParams(
          enableJavaScript: true,
          showControls: true,
          showFullscreenButton: true,
        ));

    setState(() {
      isInitialised = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInitialised
        ? YoutubePlayerIFrame(
            controller: controller,
            aspectRatio: 16 / 9,
          )
        : buildLoadingWidget();
  }
}

/*
Row(
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
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
                              )
                            ],
                          ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Circular',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
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
            onTap: () => Get.to(() => CircularUpdateScreen(aId: aID, index: 1)),
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
                        color: Style.headerYellowcolor,
                        width: 5.0,
                          ),
          InkWell(
            onTap: () => Get.to(
              () => B2BList(
                association: association,
                userid: userName,
                password: password,
              ),
            ),
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
                        color: Style.headerYellowcolor,
                        width: 5.0,
                          ),
          InkWell(
            onTap: () => Get.to(
              () => MemberListPage(
                association: association,
                userName: userName,
                password: password,
              ),
            ),
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Directory',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
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
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                                color: Style.backgroundcolor,
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
*/