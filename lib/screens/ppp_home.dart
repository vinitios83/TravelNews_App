import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/global.dart';
import 'package:travel_app/models/travel_ppp.dart';
import 'package:travel_app/screens/tourism_ppp.dart';

import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/widget/my_banners_ads.dart';

import '../element/loader.dart';
import '../services/home_ticker_controller.dart';

import '../services/remote_api.dart';

class PPPHome extends StatefulWidget {
  const PPPHome({Key? key}) : super(key: key);

  @override
  State<PPPHome> createState() => _PPPHomeState();
}

class _PPPHomeState extends State<PPPHome> {
  RxBool isTv = true.obs;
  String showncontent = "";
  String shownimg =
      "https://s3.amazonaws.com/upload.uxpin/files/1263790/1216806/PPP_mode-fbde027b665e5f0df7911a9d18a2fc3a.jpg";
  HomeTickerController tickerController = Get.put(HomeTickerController());
  List<Map<String, dynamic>> currentlist = [];

  final List<Map<String, dynamic>> states = [];
  final List<Map<String, dynamic>> countries = [];
  TravelPPP? data;
  String Dcontent = "";
  String Dimg = "";
  String Icontent = "";
  String Iimg = "";
  String? selectedValue;
  String selectedid = "1";
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  setinternational(TravelPPP? data) {
    Icontent = data!.internationalTourismboardDetails.content;
    Iimg = data.internationalTourismboardDetails.image;
    for (var j in data.internationalTourismboardDetails.countries) {
      countries.add({"value": j.city, "id": j.id.toString()});
    }
    setState(() {
      currentlist = countries;
    });
  }

  setdomestic(TravelPPP? data) {
    Dcontent = data!.nationalTourismboardDetails.content;
    Dimg = data.nationalTourismboardDetails.image;
    for (var j in data.nationalTourismboardDetails.countries) {
      states.add({"value": j.state, "id": j.id.toString()});
    }
    setState(() {
      currentlist = states;
    });
  }

  getdomestc() {
    setState(() {
      showncontent = Dcontent;
      shownimg = Dimg;
      currentlist = states;
    });
  }

  getinternational() {
    setState(() {
      showncontent = Icontent;
      shownimg = Iimg;
      currentlist = countries;
    });
  }

  getdata() async {
    data = await RemoteApi().getTravelPPPHome();
    setdomestic(data);
    setinternational(data);
    getdomestc();
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'Travel Business',
              style: TextStyle(
                  color: Style.appbarfontcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Text(
              '  PPP',
              style: TextStyle(
                  color: Style.appbarpagecolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ],
        ),
        backgroundColor: Style.appbarcolor,
        actions: [
          IconButton(
              onPressed: () {
                isTv(true);
              },
              icon: const Icon(Icons.tv)),
          IconButton(
              onPressed: () {
                isTv(false);
              },
              icon: const Icon(Icons.radio))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(250.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: shownimg,
                fit: BoxFit.fitHeight,
                height: 250,
              ),
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: Style.backgroundcolor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: (() {
                          setState(() {
                            getinternational();
                          });
                        }),
                        
                                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'International Tourism Boards',
                  style: TextStyle(
                      color: Style.tabbarfontcolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
                                ),
                    const VerticalDivider(
                        thickness: 2,
                        endIndent: 7,
                        indent: 7,
                        color: Style.othertabbarcolor),
                    InkWell(
                        onTap: (() {
                          setState(() {
                            getdomestc();
                          });
                        }),
                        
                                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    color: Style.appbarcolor,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'Domestic Tourism Boards',
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
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: RemoteApi().getTravelPPPHome(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return buildLoadingWidget();
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 32, top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: const Text(
                                '  Select from List',
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 1.2,
                                    letterSpacing: 0.2,
                                    color: Style.primaryfontcolor,
                                    fontFamily: 'Calibri Bold'),
                              ),
                              items: currentlist
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item["value"],
                                        child: Text(
                                          item["value"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              height: 1,
                                              letterSpacing: 0.2,
                                              color: Style.primaryfontcolor,
                                              fontFamily: 'Calibri Regular'),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  currentlist.forEach((element) {
                                    if (element["value"] == value) {
                                      selectedid = element["id"];
                                    }
                                    ;
                                  });
                                  StateTitle = selectedValue.toString();
                                });
                                Get.off(TourismPPP(id: selectedid));
                              },

                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                              searchController: textEditingController,
                              searchInnerWidget: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        height: 1,
                                        letterSpacing: 0.2,
                                        color: Style.primaryfontcolor,
                                        fontFamily: 'Calibri Regular'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return (item.value
                                    .toString()
                                    .contains(searchValue));
                              },
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  textEditingController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Abstract',
                          style: TextStyle(
                              fontSize: 18,
                              color: Style.primaryfontcolor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Economica'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          showncontent,
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
        },
      ),
    );
  }
}
