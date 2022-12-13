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

  var currentPage = 0;
  var subPage = 0;

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
                      width: 8,),
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
                      decoration: (this.currentPage == 1)
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
                      width: 8,),
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
                      decoration: (this.currentPage == 2)
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
                      width: 8,),
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
                      decoration: (this.currentPage == 3)
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
              height: 12,
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
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            const BoxDecoration(color: Style.backgroundcolor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (() {
                                seccontroller.animateToPage(0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  this.subPage = 0;
                                });
                              }),
                              child: Container(
                                decoration: (this.subPage == 0)
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
                                    'National',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                                width: 8,),
                            InkWell(
                              onTap: (() {
                                seccontroller.animateToPage(1,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  this.subPage = 1;
                                });
                              }),
                              child: Container(
                                decoration: (this.subPage == 1)
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
                                    'Regional',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                                width: 8,),
                            InkWell(
                              onTap: (() {
                                seccontroller.animateToPage(2,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  this.subPage = 2;
                                });
                              }),
                              child: Container(
                                decoration: (this.subPage == 2)
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
                                    'International',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                                width: 8,),
                            InkWell(
                              onTap: (() {
                                seccontroller.animateToPage(3,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  this.subPage = 3;
                                });
                              }),
                              child: Container(
                                decoration: (this.subPage == 3)
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
                                    'Buyers',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              width: 8,
                                ),
                            InkWell(
                              onTap: (() {
                                seccontroller.animateToPage(4,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  this.subPage = 4;
                                });
                              }),
                              child: Container(
                                decoration: (this.subPage == 4)
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
                                    'Sellers',
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
                        height: 12,
                      ),
                      Expanded(
                        child: PageView(
                          controller: seccontroller,
                          children: [
                            const AssociationList(),
                            Container(
                              color: Colors.amber,
                            ),
                            Container(
                              color: Colors.blueAccent,
                            ),
                            Container(
                              color: Colors.brown,
                            ),
                            Container(
                              color: Colors.cyan,
                            )
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
                  const Center(
                    child: Text("Coming Soon"),
                  ),
                  const Center(
                    child: Text("Coming Soon"),
                  ),
                  Container(
                    color: Colors.cyan,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class AssociationList extends StatefulWidget {
  const AssociationList({
    Key? key,
  }) : super(key: key);

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
    // return InkWell(
    //   onTap: () {
    //     if (widget.isLoggedIn && widget.user != null) {
    //       Get.to(
    //         () => AssociationDetailPage(
    //           association: Association(
    //             name: widget.user!.aName,
    //             id: widget.user!.aId,
    //             atype: widget.user!.aType,
    //             imageUrl:
    //                 '${AssociationHelper.URL_LIST_OF_ASSOCIATION_LOGOS}${widget.user!.aName}.jpg',
    //           ),
    //           userName: widget.user!.username,
    //           password: widget.user!.password,
    //         ),
    //       );
    //     } else {
    //       if (widget._association.name != 'FAITH') {
    //         Get.to(
    //           () => LoginDialog(association: widget._association),
    //         );
    //       } else {
    //         Get.to(
    //           () => B2BHome(
    //             association: widget._association,
    //           ),
    //         );
    //       }
    //     }
    //   },
    //   child: Card(
    //     child: Column(
    //       children: [
    //         CachedNetworkImage(
    //           imageUrl: widget._association.imageUrl,
    //           height: 120,
    //           width: 120,
    //           fit: BoxFit.fill,
    //           placeholder: (context, url) => const SizedBox(
    //             height: 20,
    //             width: 40,
    //             child: Center(
    //               child: CircularProgressIndicator(
    //                 strokeWidth: 1,
    //               ),
    //             ),
    //           ),
    //           errorWidget: (context, url, error) => const Icon(Icons.error),
    //         ),
    //         Text(
    //           (widget._association.name != 'FAITH')
    //               ? widget._association.name
    //               : 'B2B',
    //         ),
    //         Container(
    //           child: (widget.isLoggedIn)
    //               ? InkWell(
    //                   onTap: () async {
    //                     userBox.delete(widget._association.id);
    //                     await FirebaseMessaging.instance.unsubscribeFromTopic(
    //                       widget._association.name,
    //                     );
    //                   },
    //                   child: const Text(
    //                     'Sign Out',
    //                     style: TextStyle(
    //                       color: Colors.red,
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 )
    //               : InkWell(
    //                   onTap: () {
    //                     if (widget._association.name != 'FAITH') {
    //                       Get.to(
    //                         () => LoginDialog(
    //                           association: widget._association,
    //                         ),
    //                       );
    //                     } else {
    //                       Get.to(
    //                         () => B2BHome(
    //                           association: widget._association,
    //                         ),
    //                       );
    //                     }
    //                   },
    //                   child: Text(
    //                     (widget._association.name != 'FAITH')
    //                         ? 'SIGN IN'
    //                         : 'B2B IN',
    //                     style: const TextStyle(
    //                       color: Color(0xff00cb00),
    //                       fontSize: 16,
    //                     ),
    //                   ),
    //                 ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
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
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
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
                            child: Text(
                              (widget._association.name != 'FAITH')
                                  ? 'SIGN IN'
                                  : 'B2B IN',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
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
