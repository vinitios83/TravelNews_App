import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';

import '../models/deal_type.dart';
import '../controller/b2b_controller.dart';
import '../models/association_model.dart';
import '../models/b2b_model.dart';
import '../utility/colors.dart';
import 'hotel_card.dart';
import 'transport_card.dart';

class FavDealsPage extends StatefulWidget {
  const FavDealsPage({
    Key? key,
    required this.association,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final Association association;
  final String userName;
  final String password;

  @override
  State<FavDealsPage> createState() => _FavDealsPageState();
}

class _FavDealsPageState extends State<FavDealsPage> {
  final B2BController b2bController = Get.find();
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      b2bController.fetchFavDeals(
        id: widget.association.id,
        userid: widget.userName,
        password: widget.password,
      );
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

    return Obx(
      () {
        if (b2bController.isLoading.value) {
          return Scaffold(
            body: Center(child: buildLoadingWidget()),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 1.0,
                backgroundColor: Style.appbarcolor,
                title: const Text('Favourite deals',
                    style: TextStyle(
                        color: Style.appbarfontcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FavTabBar(
                  tabs: tabs,
                  hotel: b2bController.favListHotel,
                  package: b2bController.favListPackages,
                  transport: b2bController.favListTransport,
                  association: widget.association,
                  userName: widget.userName,
                  password: widget.password,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class FavTabBar extends StatelessWidget {
  const FavTabBar({
    Key? key,
    required this.tabs,
    required this.hotel,
    required this.package,
    required this.transport,
    required this.association,
    required this.userName,
    required this.password,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Hotel> hotel;
  final List<Hotel> package;
  final List<Transport> transport;
  final Association association;
  final String userName;
  final String password;

  @override
  Widget build(BuildContext context) {
    return ContainedTabBarView(
      tabs: tabs,
      tabBarProperties: TabBarProperties(
        height: 45,
        background: Container(
            // color: AppTheme.kPrimaryColor,
            ),
        indicatorColor: Colors.transparent,
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
        FavPackage(
          package: package,
          org: association,
          userName: userName,
          password: password,
        ),
        FavHotel(
          hotel: hotel,
          org: association,
          password: password,
          userName: userName,
        ),
        FavTransport(
          transport: transport,
          org: association,
          password: password,
          userName: userName,
        ),
      ],
    );
  }
}

class FavPackage extends StatelessWidget {
  const FavPackage({
    Key? key,
    required this.package,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final List<Hotel> package;
  final Association org;
  final String userName;
  final String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (package.isEmpty)
          ? const Center(
              child: Text('No Data'),
            )
          : ListView.builder(
              itemCount: package.length,
              itemBuilder: (context, index) {
                if (org.name == 'FAITH') {
                  return HotelCard(
                    hotel: package[index],
                    org: org.name,
                    dealType: DealType.Fav,
                    password: password,
                    userName: userName,
                    assId: org.id,
                  );
                } else {
                  if (org.name == package[index].assoname) {
                    return HotelCard(
                      hotel: package[index],
                      org: org.name,
                      dealType: DealType.Fav,
                      userName: userName,
                      password: password,
                      assId: org.id,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
    );
  }
}

class FavHotel extends StatelessWidget {
  const FavHotel({
    Key? key,
    required this.hotel,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final List<Hotel> hotel;
  final Association org;
  final String userName;
  final String password;
  @override
  Widget build(BuildContext context) {
    return (hotel.isEmpty)
        ? const Center(
            child: Text('No Data'),
          )
        : ListView.builder(
            itemCount: hotel.length,
            itemBuilder: (context, index) {
              if (org.name == 'FAITH') {
                return HotelCard(
                  hotel: hotel[index],
                  org: org.name,
                  dealType: DealType.Fav,
                  userName: userName,
                  password: password,
                  assId: org.id,
                );
              } else {
                if (org.name == hotel[index].assoname) {
                  return HotelCard(
                    hotel: hotel[index],
                    org: org.name,
                    dealType: DealType.Fav,
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
}

class FavTransport extends StatelessWidget {
  const FavTransport({
    Key? key,
    required this.transport,
    required this.org,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final List<Transport> transport;
  final Association org;
  final String userName;
  final String password;
  @override
  Widget build(BuildContext context) {
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
                  dealType: DealType.Fav,
                  org: org.name,
                  password: password,
                  userName: userName,
                  transport: transport[index],
                );
              } else {
                if (org.name == transport[index].assoname) {
                  return TransportCard(
                    assId: org.id,
                    dealType: DealType.Fav,
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
}
