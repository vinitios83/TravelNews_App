import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';
import '../models/deal_type.dart';
import '../controller/b2b_controller.dart';
import '../models/association_model.dart';
import '../models/b2b_model.dart';

import 'hotel_card.dart';
import 'transport_card.dart';

class MyDealPage extends StatefulWidget {
  const MyDealPage({
    Key? key,
    required this.association,
    required this.userName,
    required this.password,
    required this.initialIndex,
  }) : super(key: key);
  final Association association;
  final String userName;
  final String password;
  final int initialIndex;

  @override
  State<MyDealPage> createState() => _MyDealPageState();
}

class _MyDealPageState extends State<MyDealPage> {
  final B2BController b2bController = Get.put(B2BController());
  @override
  initState() {
    super.initState();
    b2bController.fetchMyDeals(
        userid: widget.userName,
      ).then((value){
        setState(() {
          
        });
      });
  }


  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      const Tab(
        text: 'PACKAGES',
        
      ),
      const Tab(
        text: 'HOTELS',
      ),
      const Tab(
        text: 'TRANSPORT',
      ),
    ];

    // q
          return SafeArea(
            child: Scaffold(
              body: SizedBox(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                child: MyDealsTabBar(
                  tabs: tabs,
                  hotel: b2bController.myListHotel,
                  package: b2bController.myListPackages,
                  transport: b2bController.myListTransport,
                  association: widget.association,
                  userName: widget.userName,
                  password: widget.password,
                  initialIndex: widget.initialIndex,
                ),
              ),
            ),
          );
    //     }
    //   },
    // );
  }
}

class MyDealsTabBar extends StatelessWidget {
  const MyDealsTabBar({
    Key? key,
    required this.tabs,
    required this.hotel,
    required this.package,
    required this.transport,
    required this.association,
    required this.userName,
    required this.password,
    required this.initialIndex,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Hotel> hotel;
  final List<Hotel> package;
  final List<Transport> transport;
  final Association association;
  final String userName;
  final String password;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return ContainedTabBarView(
      tabs: tabs,
      initialIndex: initialIndex,
      tabBarProperties: TabBarProperties(
        height: 45,
        background: Container(
            color: Style.appbarcolor,
            ),
        indicatorColor: Colors.white,
        padding: const EdgeInsets.all(8),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
          wordSpacing: 0.4,
          fontSize: 14,
        ),
        margin: EdgeInsets.zero,
        isScrollable: false,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        position: TabBarPosition.top,
      ),
      views: [
        MyPackage(
          package: package,
          org: association,
          userName: userName,
          password: password,
        ),
        MyHotel(
          hotel: hotel,
          org: association,
          userName: userName,
          password: password,
        ),
        MyTransport(
          transport: transport,
          org: association,
          userName: userName,
          password: password,
        ),
      ],
    );
  }
}

class MyPackage extends StatelessWidget {
  MyPackage({
    Key? key,
    required this.package,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  List<Hotel> package;
  final Association org;
  final String userName;
  final String password;
  final B2BController b2bController = Get.put(B2BController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Obx(
        () {
          if (b2bController.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(
                  // backgroundColor: AppTheme.kPrimaryColor,
                  ),
            );
          } else {
            // package = b2bController.myListPackages;
            return (package.isEmpty)
                ? const Center(child: Text('No Data'))
                : ListView.builder(
                    itemCount: package.length,
                    itemBuilder: (context, index) {
                      if (org.name == 'FAITH') {
                        return HotelCard(
                          hotel: package[index],
                          org: org.name,
                          dealType: DealType.MYDEAL,
                          userName: userName,
                          password: password,
                          assId: org.id,
                        );
                      } else {
                        if (org.name == package[index].assoname) {
                          return HotelCard(
                            hotel: package[index],
                            org: org.name,
                            dealType: DealType.MYDEAL,
                            userName: userName,
                            password: password,
                            assId: org.id,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                  );
          }
        },
      ),
    );
  }
}

class MyHotel extends StatelessWidget {
  MyHotel({
    Key? key,
    required this.hotel,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  List<Hotel> hotel;
  final Association org;
  final String userName;
  final String password;
  final B2BController b2bController = Get.put(B2BController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (b2bController.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(
                  // backgroundColor: AppTheme.kPrimaryColor,
                  ),
            );
          } else {
            // hotel = b2bController.myListHotel;
            return (hotel.isEmpty)
                ? const Center(child: Text('No Data'))
                : ListView.builder(
                    itemCount: hotel.length,
                    itemBuilder: (context, index) {
                      if (org.name == 'FAITH') {
                        return HotelCard(
                          hotel: hotel[index],
                          org: org.name,
                          dealType: DealType.MYDEAL,
                          userName: userName,
                          password: password,
                          assId: org.id,
                        );
                      } else {
                        if (org.name == hotel[index].assoname) {
                          return HotelCard(
                            hotel: hotel[index],
                            org: org.name,
                            dealType: DealType.MYDEAL,
                            userName: userName,
                            password: password,
                            assId: org.id,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    },
                  );
          }
        },
      ),
    );
  }
}

class MyTransport extends StatelessWidget {
  MyTransport({
    Key? key,
    required this.transport,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  List<Transport> transport;
  final Association org;
  final String userName;
  final String password;
  final B2BController b2bController = Get.put(B2BController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (b2bController.isLoading.isTrue) {
        return const Center(
          child: CircularProgressIndicator(
              // backgroundColor: AppTheme.kPrimaryColor,
              ),
        );
      } else {
        // transport = b2bController.myListTransport;
        return (transport.isEmpty)
            ? const Center(
                child: Text('No Data'),
              )
            : ListView.builder(
                itemCount: transport.length,
                itemBuilder: (context, index) {
                  if (org.name == 'FAITH') {
                    return TransportCard(
                      assId: org.id,
                      dealType: DealType.MYDEAL,
                      org: org.name,
                      password: password,
                      userName: userName,
                      transport: transport[index],
                    );
                  } else {
                    if (org.name == transport[index].assoname) {
                      return TransportCard(
                        assId: org.id,
                        dealType: DealType.MYDEAL,
                        org: org.name,
                        password: password,
                        userName: userName,
                        transport: transport[index],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                },
              );
      }
    });
  }
}
