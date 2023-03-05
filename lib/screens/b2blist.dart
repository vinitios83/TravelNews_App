import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/screens/transport.dart';
import 'package:travel_app/utility/colors.dart';

import '../../models/deal_type.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controller/b2b_controller.dart';
import '../../models/association_model.dart';
import '../widget/create_hotel.dart';
import '../widget/create_package.dart';
import '../widget/create_transport.dart';
import '../widget/fav_deals_page.dart';
import '../widget/my_banners_ads.dart';
import '../widget/mydeal_page.dart';

import 'hotel.dart';
import 'package.dart';

class B2BList extends StatefulWidget {
  const B2BList({
    Key? key,
    required this.association,
    this.userid = '',
    this.password = '',
  }) : super(key: key);
  final Association association;
  final String userid;
  final String password;

  @override
  State<B2BList> createState() => _B2BListState();
}

class _B2BListState extends State<B2BList> {
  final B2BController b2bController = Get.put(B2BController());

  final controller = PageController(initialPage: 0);
  final seccontroller = PageController(initialPage: 0);
  final thirdcontroller = PageController(initialPage: 0);
  final fourthcontroller = PageController(initialPage: 0);
  final selleroffercontroller = PageController(initialPage: 0);
  final sellercreatecontroller = PageController(initialPage: 0);
  final myoffersellercontroller = PageController(initialPage: 0);

  Future<void> loadInitalData() async {
    await b2bController.fetchB2BDeals();
    b2bController.fetchFavDeals(
      id: widget.association.id,
      userid: widget.userid,
      password: widget.password,
    );
  }

  @override
  void initState() {
    loadInitalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (b2bController.isLoading.isTrue) {
          return Scaffold(
            body: Center(
              child: buildLoadingWidget(),
            ),
          );
        } else {
          return SafeArea(
              child: Scaffold(
            backgroundColor: Style.backgroundcolor,
            bottomNavigationBar: const MyBannerAds(),
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 77, 50, 50),
              title: const Text(
                'Deals',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Style.appbarfontcolor),
              ),
              actions: [
                (widget.association.id == '12')
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () => Get.to(
                          () => FavDealsPage(
                            association: widget.association,
                            password: widget.password,
                            userName: widget.userid,
                          ),
                        ),
                        child: const Icon(
                          CupertinoIcons.heart_fill,
                          color: Colors.redAccent,
                          size: 26,
                        ),
                      ),
                const WidthBox(10),
              ],
            ),
            body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(color: Style.backgroundcolor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: (() {
                                controller.animateToPage(0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              }),
                              child: const Text('Buyers',
                                  style: TextStyle(
                                      color: Style.tabbarfontcolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          const VerticalDivider(
                              thickness: 2,
                              endIndent: 7,
                              indent: 7,
                              color: Style.verticaldividercolor),
                          InkWell(
                              onTap: (() {
                                controller.animateToPage(1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              }),
                              child: const Text('Sellers',
                                  style: TextStyle(
                                      color: Style.tabbarfontcolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          const VerticalDivider(
                              thickness: 2,
                              endIndent: 7,
                              indent: 7,
                              color: Style.verticaldividercolor),
                          InkWell(
                              onTap: (() {
                                controller.animateToPage(2,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                              }),
                              child: const Text('Last Min. Deals',
                                  style: TextStyle(
                                      color: Style.tabbarfontcolor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView(controller: controller, children: [
                        Column(
                          children: [
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Style.othertabbarcolor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: (() {
                                        seccontroller.animateToPage(0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Demands',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        seccontroller.animateToPage(1,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Create Demands',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        seccontroller.animateToPage(2,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('My Demands',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: 
                              PageView(
                                controller: seccontroller,
                                children: [
                                  Container(
                                    color: Colors.orange,
                                  ),
                                  Container(
                                    color: Colors.redAccent,
                                  ),
                                  Container(
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Style.othertabbarcolor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: (() {
                                        thirdcontroller.animateToPage(0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Offers',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        thirdcontroller.animateToPage(1,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Create Offers',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        thirdcontroller.animateToPage(2,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('My Offers',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                controller: thirdcontroller,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Style.othertabbarcolor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                onTap: (() {
                                                  selleroffercontroller
                                                      .animateToPage(0,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Packages',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  selleroffercontroller
                                                      .animateToPage(1,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Hotels',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  selleroffercontroller
                                                      .animateToPage(2,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Transport',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: PageView(
                                          controller: selleroffercontroller,
                                          children: [
                                            B2BPackage(
                                              org: widget.association,
                                              dealType: DealType.DEAL,
                                              userName: '',
                                              password: '',
                                            ),
                                            B2BHotel(
                                              org: widget.association,
                                              dealType: DealType.DEAL,
                                              userName: '',
                                              password: '',
                                            ),
                                            B2BTransport(
                                              org: widget.association,
                                              username: '',
                                              password: '',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Style.othertabbarcolor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                onTap: (() {
                                                  sellercreatecontroller
                                                      .animateToPage(0,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Packages',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  sellercreatecontroller
                                                      .animateToPage(1,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Hotels',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  sellercreatecontroller
                                                      .animateToPage(2,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Transport',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: PageView(
                                          controller: sellercreatecontroller,
                                          children: [
                                            PackageCreateScreen(
                                              association: widget.association,
                                              username: widget.userid,
                                              password: widget.password,
                                            ),
                                            CreateHotelScreen(
                                              association: widget.association,
                                              username: widget.userid,
                                              password: widget.password,
                                            ),
                                            CreateTransportScreen(
                                              association: widget.association,
                                              username: widget.userid,
                                              password: widget.password,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                            color: Style.othertabbarcolor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                onTap: (() {
                                                  myoffersellercontroller
                                                      .animateToPage(0,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Packages',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  myoffersellercontroller
                                                      .animateToPage(1,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Hotels',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            const VerticalDivider(
                                                thickness: 2,
                                                endIndent: 7,
                                                indent: 7,
                                                color:
                                                    Style.verticaldividercolor),
                                            InkWell(
                                                onTap: (() {
                                                  myoffersellercontroller
                                                      .animateToPage(2,
                                                          duration:
                                                              const Duration(
                                                                  seconds: 1),
                                                          curve:
                                                              Curves.easeInOut);
                                                }),
                                                child: const Text('Transport',
                                                    style: TextStyle(
                                                        color: Style
                                                            .tabbarfontcolor,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: PageView(
                                          controller: myoffersellercontroller,
                                          children: [
                                            MyDealPage(
                                              association: widget.association,
                                              password: widget.password,
                                              userName: widget.userid,
                                              initialIndex: 0,
                                            ),
                                            MyDealPage(
                                              association: widget.association,
                                              password: widget.password,
                                              userName: widget.userid,
                                              initialIndex: 1,
                                            ),
                                            MyDealPage(
                                              association: widget.association,
                                              password: widget.password,
                                              userName: widget.userid,
                                              initialIndex: 2,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration:
                                  const BoxDecoration(color: Style.othertabbarcolor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: (() {
                                        fourthcontroller.animateToPage(0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Packages',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        fourthcontroller.animateToPage(1,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Hotel Deal',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        fourthcontroller.animateToPage(2,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Transport',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  const VerticalDivider(
                                      thickness: 2,
                                      endIndent: 7,
                                      indent: 7,
                                      color: Style.verticaldividercolor),
                                  InkWell(
                                      onTap: (() {
                                        fourthcontroller.animateToPage(3,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut);
                                      }),
                                      child: const Text('Flight deals',
                                          style: TextStyle(
                                              color: Style.tabbarfontcolor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)))
                                ],
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                controller: fourthcontroller,
                                children: const [],
                              ),
                            )
                          ],
                        ),
                        //
                      ]),
                    )
                  ],
                )),
          ));
        }
      },
    );
  }
}
