import 'package:flutter/material.dart';
import 'package:travel_app/utility/colors.dart';
import '../../models/association_model.dart';

import '../widget/create_hotel.dart';
import '../widget/create_package.dart';
import '../widget/create_transport.dart';

class CreateDealsScreen extends StatefulWidget {
  const CreateDealsScreen({
    Key? key,
    required this.index,
    required this.association,
    required this.username,
    required this.password,
  }) : super(key: key);

  final int index;
  final Association association;
  final String password;
  final String username;

  @override
  State<CreateDealsScreen> createState() => _CreateDealsScreenState();
}

class _CreateDealsScreenState extends State<CreateDealsScreen> {
  late int myIndex;
  late String title;
  final controller = PageController(initialPage: 0);
  @override
  void initState() {
    myIndex = widget.index;
    title = (myIndex == 0)
        ? 'Create Pacakge'
        : (myIndex == 1)
            ? 'Create Hotel Deal'
            : 'Create Transport Deal';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      // appBar: AppBar(
      //   backgroundColor: Style.appbarcolor,
      //   title: Text(title,
      //       style: TextStyle(
      //           color: Style.appbarfontcolor,
      //           fontWeight: FontWeight.bold,
      //           fontSize: 30)),
      // ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  children: [
                    PackageCreateScreen(
                      association: widget.association,
                      username: widget.username,
                      password: widget.password,
                    ),
                    CreateHotelScreen(
                      association: widget.association,
                      username: widget.username,
                      password: widget.password,
                    ),
                    CreateTransportScreen(
                      association: widget.association,
                      username: widget.username,
                      password: widget.password,
                    ),
                  ],
                ),
              )
            ],
          )
          // ContainedTabBarView(
          //   tabs: tabs,
          //   initialIndex: widget.index,
          //   onChange: (ind) {
          //     setState(() {
          //       myIndex = ind;
          //       title = (myIndex == 0)
          //           ? 'Create Pacakge'
          //           : (myIndex == 1)
          //               ? 'Create Hotel Deal'
          //               : 'Create Transport Deal';
          //     });
          //   },
          //   callOnChangeWhileIndexIsChanging: true,
          //   tabBarProperties: TabBarProperties(
          //     height: 45,
          //     background: Container(color: Colors.black),
          //     indicatorColor: Colors.transparent,
          //     padding: const EdgeInsets.all(8),
          //     labelStyle: const TextStyle(
          //       color: Colors.white,
          //       fontWeight: FontWeight.w700,
          //       letterSpacing: 0.2,
          //       wordSpacing: 0.4,
          //       fontSize: 14,
          //     ),
          //     margin: EdgeInsets.zero,
          //     isScrollable: false,
          //     labelPadding: const EdgeInsets.symmetric(horizontal: 10),
          //     position: TabBarPosition.top,
          //   ),
          //   views: [
          //     PackageCreateScreen(
          //       association: widget.association,
          //       username: widget.username,
          //       password: widget.password,
          //     ),
          //     CreateHotelScreen(
          //       association: widget.association,
          //       username: widget.username,
          //       password: widget.password,
          //     ),
          //     CreateTransportScreen(
          //       association: widget.association,
          //       username: widget.username,
          //       password: widget.password,
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
