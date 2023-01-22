import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controller/association_controller.dart';
import '../main.dart';
import '../models/association_model.dart';
import '../models/user_model.dart';
import '../services/associatin_helper.dart';
import '../widget/login_dialogue.dart';
import 'association_details_page.dart';
import 'b2b_home.dart';
import 'package.dart';
import '../../models/deal_type.dart';
import 'hotel.dart';
import 'package:travel_app/screens/transport.dart';
import '../widget/create_hotel.dart';
import '../widget/create_package.dart';
import '../widget/create_transport.dart';
import '../widget/mydeal_page.dart';
import '../../controller/b2b_controller.dart';

class AssociationPage extends StatefulWidget {
  const AssociationPage({Key? key}) : super(key: key);

  @override
  State<AssociationPage> createState() => _AssociationPageState();
}

class _AssociationPageState extends State<AssociationPage>
    with SingleTickerProviderStateMixin {
  final AssociationController associationController =
      Get.put(AssociationController());
  final controller = PageController(initialPage: 0);
  final seccontroller = PageController(initialPage: 0);
  final buyercontroller = PageController(initialPage: 0);
  final thirdcontroller = PageController(initialPage: 0);
  final fourthcontroller = PageController(initialPage: 0);
  final selleroffercontroller = PageController(initialPage: 0);
  final sellercreatecontroller = PageController(initialPage: 0);
  final myoffersellercontroller = PageController(initialPage: 0);
  final B2BController b2bController = Get.put(B2BController());
  late Box<UserModel> userBox;
  var currentPage = 0;
  var subPage = 0;
  UserModel? user;

  Future<void> loadInitalData() async {
    await b2bController.fetchB2BDeals();
    b2bController.fetchFavDeals(
      id: associationController.b2bAssociation?.id ?? '',
      userid: '',
      password: '',
    );
  }

  @override
  void initState() {
    super.initState();

    associationController.appBarTitle.value = 'ASSOCIATIONS';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loadInitalData();
    userBox = Hive.box<UserModel>(userBoxName);
    int len = userBox.length;
    user = userBox.get(associationController.b2bAssociation?.id ?? "");
    return Scaffold(
        backgroundColor: Style.backgroundcolor,
        appBar: AppBar(
          backgroundColor: Style.appbarcolor,
          automaticallyImplyLeading: true,
          title: Row(
            children: const [
              Text('Travel Business',
                  style: TextStyle(
                      color: Style.appbarfontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(width: 8),
              Text(
                'B2B',
                style: TextStyle(
                    color: Style.appbarpagecolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Style.headerYellowcolor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (() {
                      controller.jumpToPage(0);
                      setState(() {
                        this.currentPage = 0;
                      });
                    }),
                    child: Container(
                      decoration: (this.currentPage == 0)
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  color: Style.backgroundcolor,
                                )
                              ],
                            )
                          : BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
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
                  const VerticalDivider(
                    color: Style.headerYellowcolor,
                    width: 5,
                  ),
                  InkWell(
                    onTap: (() {
                      controller.jumpToPage(1);
                      setState(() {
                        this.currentPage = 1;
                      });
                    }),
                    child: Container(
                      decoration: (this.currentPage == 1)
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  color: Style.backgroundcolor,
                                )
                              ],
                            )
                          : BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Text(
                          'Forex',
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
                    width: 5,
                  ),
                  InkWell(
                    onTap: (() {
                      controller.jumpToPage(2);
                      setState(() {
                        this.currentPage = 2;
                      });
                    }),
                    child: Container(
                      decoration: (this.currentPage == 2)
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  color: Style.backgroundcolor,
                                )
                              ],
                            )
                          : BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Text(
                          'Insurance',
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
                    width: 5,
                  ),
                  InkWell(
                    onTap: (() {
                      controller.jumpToPage(3);
                      setState(() {
                        this.currentPage = 3;
                      });
                    }),
                    child: Container(
                      decoration: (this.currentPage == 3)
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                  color: Style.backgroundcolor,
                                )
                              ],
                            )
                          : BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Text(
                          'Spcl Offers',
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
            const Divider(
              height: 4,
              color: Colors.white,
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    this.currentPage = value;
                  });
                },
                children: [
                  Column(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 85.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                              color: Style.backgroundcolor,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (() {
                                seccontroller.jumpToPage(0);
                                setState(() {
                                  this.subPage = 0;
                                });
                              }),
                              child: Container(
                                  height: 35.0,
                                  decoration: (this.subPage == 0)
                                      ? BoxDecoration()
                                      : BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'National',
                                        style: TextStyle(
                                            color: (this.subPage == 0)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )),
                            ),
                            const VerticalDivider(
                              color: Colors.red,
                              width: 2,
                            ),
                            InkWell(
                              onTap: (() {
                                seccontroller.jumpToPage(1);
                                setState(() {
                                  this.subPage = 1;
                                });
                              }),
                              child: Container(
                                  height: 35.0,
                                  decoration: (this.subPage == 1)
                                      ? BoxDecoration()
                                      : BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'Regional',
                                        style: TextStyle(
                                            color: (this.subPage == 1)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )),
                            ),
                            const VerticalDivider(
                              width: 2,
                            ),
                            InkWell(
                              onTap: (() {
                                seccontroller.jumpToPage(2);
                                setState(() {
                                  this.subPage = 2;
                                });
                              }),
                              child: Container(
                                  height: 35.0,
                                  decoration: (this.subPage == 2)
                                      ? BoxDecoration()
                                      : BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'International',
                                        style: TextStyle(
                                            color: (this.subPage == 2)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )),
                            ),
                            const VerticalDivider(
                              width: 2,
                            ),
                            InkWell(
                              onTap: (() {
                                seccontroller.jumpToPage(3);
                                setState(() {
                                  this.subPage = 3;
                                });
                              }),
                              child: Container(
                                  height: 35.0,
                                  decoration: (this.subPage == 3)
                                      ? BoxDecoration()
                                      : BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'Buyers',
                                        style: TextStyle(
                                            color: (this.subPage == 3)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )),
                            ),
                            const VerticalDivider(
                              width: 2,
                            ),
                            InkWell(
                              onTap: (() {
                                seccontroller.jumpToPage(4);
                                setState(() {
                                  this.subPage = 4;
                                });
                              }),
                              child: Container(
                                  height: 35.0,
                                  decoration: (this.subPage == 4)
                                      ? BoxDecoration()
                                      : BoxDecoration(color: Colors.white),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      child: Text(
                                        'Sellers',
                                        style: TextStyle(
                                            color: (this.subPage == 4)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 12,
                      ),
                      Expanded(
                        child: PageView(
                          controller: seccontroller,
                          children: [
                            const AssociationList(
                              selectedTabName: 'National',
                            ),
                            const AssociationList(selectedTabName: 'Regional'),
                            const AssociationList(
                                selectedTabName: 'International'),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: (len == 0 ||
                                      associationController.b2bAssociation ==
                                          null)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Center(
                                          child: InkWell(
                                            onTap: (() {
                                              seccontroller.jumpToPage(0);
                                              setState(() {
                                                this.subPage = 0;
                                              });
                                            }),
                                            child: Container(
                                              decoration: BoxDecoration(
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
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                      color:
                                                          Style.tabbarfontcolor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          height: 8,
                                        ),
                                        const Image(
                                            image: AssetImage(
                                                'assets/imgBuyer.jpeg'))
                                      ],
                                    )
                                  : Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: const BoxDecoration(
                                                  color:
                                                      Style.headerYellowcolor),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(0,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'Demands',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  const VerticalDivider(
                                                      thickness: 2,
                                                      endIndent: 7,
                                                      indent: 7,
                                                      color: Style
                                                          .verticaldividercolor),
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(1,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'Create Demands',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  const VerticalDivider(
                                                      thickness: 2,
                                                      endIndent: 7,
                                                      indent: 7,
                                                      color: Style
                                                          .verticaldividercolor),
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(2,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'My Demands',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              selleroffercontroller,
                                                          children: [
                                                            B2BPackage(
                                                              org: associationController
                                                                  .b2bAssociation!,
                                                              dealType:
                                                                  DealType.DEAL,
                                                              userName: '',
                                                              password: '',
                                                            ),
                                                            B2BHotel(
                                                              org: associationController
                                                                  .b2bAssociation!,
                                                              dealType:
                                                                  DealType.DEAL,
                                                              userName: '',
                                                              password: '',
                                                            ),
                                                            B2BTransport(
                                                              org: associationController
                                                                  .b2bAssociation!,
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              sellercreatecontroller,
                                                          children: [
                                                            PackageCreateScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                            ),
                                                            CreateHotelScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                            ),
                                                            CreateTransportScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              myoffersellercontroller,
                                                          children: [
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
                                                              initialIndex: 0,
                                                            ),
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
                                                              initialIndex: 1,
                                                            ),
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
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
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: (len == 0 ||
                                      associationController.b2bAssociation ==
                                          null)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Center(
                                          child: InkWell(
                                            onTap: (() {
                                              seccontroller.jumpToPage(0);
                                              setState(() {
                                                this.subPage = 0;
                                              });
                                            }),
                                            child: Container(
                                              decoration: BoxDecoration(
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
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                child: Text(
                                                  'Sign In',
                                                  style: TextStyle(
                                                      color:
                                                          Style.tabbarfontcolor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Divider(
                                          height: 8,
                                        ),
                                        const Image(
                                            image: AssetImage(
                                                'assets/imgSeller.jpeg'))
                                      ],
                                    )
                                  : Obx(() {
                                      if (b2bController.isLoading.isTrue) {
                                        return Scaffold(
                                          body: Center(
                                            child: buildLoadingWidget(),
                                          ),
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: const BoxDecoration(
                                                  color:
                                                      Style.headerYellowcolor),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(0,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'Offers',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  const VerticalDivider(
                                                      thickness: 2,
                                                      endIndent: 7,
                                                      indent: 7,
                                                      color: Style
                                                          .verticaldividercolor),
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(1,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'Create Offers',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  const VerticalDivider(
                                                      thickness: 2,
                                                      endIndent: 7,
                                                      indent: 7,
                                                      color: Style
                                                          .verticaldividercolor),
                                                  InkWell(
                                                      onTap: (() {
                                                        thirdcontroller
                                                            .animateToPage(2,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeInOut);
                                                      }),
                                                      child: const Text(
                                                          'My Offers',
                                                          style: TextStyle(
                                                              color: Style
                                                                  .tabbarfontcolor,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  selleroffercontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              selleroffercontroller,
                                                          children: [
                                                            B2BPackage(
                                                              org: associationController
                                                                  .b2bAssociation!,
                                                              dealType:
                                                                  DealType.DEAL,
                                                              userName: '',
                                                              password: '',
                                                            ),
                                                            B2BHotel(
                                                              org: associationController
                                                                  .b2bAssociation!,
                                                              dealType:
                                                                  DealType.DEAL,
                                                              userName: '',
                                                              password: '',
                                                            ),
                                                            B2BTransport(
                                                              org: associationController
                                                                  .b2bAssociation!,
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  sellercreatecontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              sellercreatecontroller,
                                                          children: [
                                                            PackageCreateScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                            ),
                                                            CreateHotelScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                            ),
                                                            CreateTransportScreen(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              username:
                                                                  user?.aId ??
                                                                      "",
                                                              password:
                                                                  user?.password ??
                                                                      "",
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: Style
                                                                    .othertabbarcolor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(0,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Packages',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(1,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Hotels',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                            const VerticalDivider(
                                                                thickness: 2,
                                                                endIndent: 7,
                                                                indent: 7,
                                                                color: Style
                                                                    .verticaldividercolor),
                                                            InkWell(
                                                                onTap: (() {
                                                                  myoffersellercontroller.animateToPage(2,
                                                                      duration: const Duration(
                                                                          seconds:
                                                                              1),
                                                                      curve: Curves
                                                                          .easeInOut);
                                                                }),
                                                                child: const Text(
                                                                    'Transport',
                                                                    style: TextStyle(
                                                                        color: Style
                                                                            .tabbarfontcolor,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold))),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: PageView(
                                                          controller:
                                                              myoffersellercontroller,
                                                          children: [
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
                                                              initialIndex: 0,
                                                            ),
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
                                                              initialIndex: 1,
                                                            ),
                                                            MyDealPage(
                                                              association:
                                                                  associationController
                                                                      .b2bAssociation!,
                                                              password:
                                                                  user?.password ??
                                                                      "",
                                                              userName:
                                                                  user?.aId ??
                                                                      "",
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
                                        );
                                      }
                                    }),
                            ),
                          ],
                          onPageChanged: (value) {
                            setState(() {
                              this.subPage = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 8,
                        ),
                        const Image(image: AssetImage('assets/imgForex.jpeg'))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Text(
                              'Coming Soon',
                              style: TextStyle(
                                  color: Style.tabbarfontcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 8,
                        ),
                        const Image(
                            image: AssetImage('assets/imgInsurance.jpeg'))
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      if (b2bController.isLoading.isTrue) {
                        return Scaffold(
                          body: Center(
                            child: buildLoadingWidget(),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  color: Style.othertabbarcolor),
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
                        );
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class AssociationList extends StatefulWidget {
  final String selectedTabName;
  const AssociationList({Key? key, required this.selectedTabName})
      : super(key: key);

  @override
  State<AssociationList> createState() => _AssociationListState();
}

class _AssociationListState extends State<AssociationList> {
  late Box<UserModel> userBox;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>(userBoxName);
  }

  @override
  Widget build(BuildContext context) {
    // final AssociationController associationController = Get.find();
    final AssociationController associationController =
        Get.put(AssociationController());
    associationController.selectedAType.value = widget.selectedTabName;
    // associationController.selectedAType.value == 'National';
    return SizedBox(
      height: 100,
      // width: 100,
      child: Obx(
        () {
          if (associationController.isLoading.value) {
            return Center(
              child: buildLoadingWidget(),
            );
          } else {
            return ValueListenableBuilder(
              valueListenable: userBox.listenable(),
              builder: (context, Box<UserModel> user, _) {
                int len = userBox.length;
                return ListView.builder(
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2),
                  // scrollDirection: Axis.horizontal,
                  itemCount: associationController.associationList.length,
                  itemBuilder: (context, index) {
                    Association association =
                        associationController.associationList[index];
                    // print(_association.name);

                    UserModel? user = userBox.get(association.id);
                    if (len == 0 && (association.name == 'FAITH')) {
                      return const SizedBox.shrink();
                    }
                    if (association.atype ==
                        associationController.selectedAType.value) {
                      return AssociationTile(
                        association: association,
                        isLoggedIn: (user != null) ? true : false,
                        user: user,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AssociationTile extends StatefulWidget {
  const AssociationTile({
    Key? key,
    required Association association,
    required this.isLoggedIn,
    this.user,
  })  : _association = association,
        super(key: key);

  final Association _association;
  final bool isLoggedIn;
  final UserModel? user;

  @override
  State<AssociationTile> createState() => _AssociationTileState();
}

class _AssociationTileState extends State<AssociationTile> {
  late Box<UserModel> userBox;
  late bool isLogin;
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box<UserModel>(userBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isLoggedIn && widget.user != null) {
          Get.to(
            () => AssociationDetailPage(
              association: Association(
                name: widget.user!.aName,
                id: widget.user!.aId,
                atype: widget.user!.aType,
                imageUrl:
                    '${AssociationHelper.URL_LIST_OF_ASSOCIATION_LOGOS}${widget.user!.aName}.jpg',
              ),
              userName: widget.user!.username,
              password: widget.user!.password,
            ),
          );
        } else {
          if (widget._association.name != 'FAITH') {
            Get.to(
              () => LoginDialog(association: widget._association),
            );
          } else {
            Get.to(
              () => B2BHome(
                association: widget._association,
              ),
            );
          }
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WidthBox(10),
                CachedNetworkImage(
                  imageUrl: widget._association.imageUrl,
                  width: 70,
                  height: 35,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(
                    height: 20,
                    width: 40,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const WidthBox(10),
                Text(
                  (widget._association.name != 'FAITH')
                      ? widget._association.name
                      : 'B2B',
                ),
                const Spacer(),
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Style.backgroundcolor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: (widget.isLoggedIn)
                        ? InkWell(
                            onTap: () async {
                              userBox.delete(widget._association.id);
                              await FirebaseMessaging.instance
                                  .unsubscribeFromTopic(
                                widget._association.name,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              if (widget._association.name != 'FAITH') {
                                Get.to(
                                  () => LoginDialog(
                                    association: widget._association,
                                  ),
                                );
                              } else {
                                Get.to(
                                  () => B2BHome(
                                    association: widget._association,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 0.0,
                                    spreadRadius: 1.0,
                                    color: Style.othertabbarcolor,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 12),
                                child: Text(
                                  (widget._association.name != 'FAITH')
                                      ? 'SIGN IN'
                                      : 'B2B IN',
                                  style: TextStyle(
                                      color: Style.tabbarfontcolor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                const WidthBox(15),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Style.dividercolor,
            ),
          ],
        ),
      ),
    );
  }
}
