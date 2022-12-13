// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:travel_app/screens/investment_ppp.dart';
// import 'package:travel_app/screens/tourism_ppp.dart';

// import 'package:travel_app/utility/colors.dart';
// import 'package:travel_app/widget/my_banners_ads.dart';

// import '../element/loader.dart';
// import '../services/home_ticker_controller.dart';

// import '../services/remote_api.dart';

// class ResourcePPP extends StatefulWidget {
//   const ResourcePPP({Key? key}) : super(key: key);

//   @override
//   State<ResourcePPP> createState() => _ResourcePPPState();
// }

// class _ResourcePPPState extends State<ResourcePPP> {
//   RxBool isTv = true.obs;

//   String bannerimg =
//       "https://s3.amazonaws.com/upload.uxpin/files/1263790/1216806/Raipur-9de2fb718ed47c6eb1e3cbf6e019ae5f.jpg";
//   final RemoteApi _remoteApi = RemoteApi();
//   HomeTickerController tickerController = Get.put(HomeTickerController());

//   List maintab = [
  
//   ];
//   List othertab = ["E-brouchers", "Videos", "Photographs"];
//   int maintabselectedindex = 2;
//   int othertabselectedindex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Style.backgroundcolor,
//       bottomNavigationBar: const MyBannerAds(),
//       appBar: AppBar(
//         title: Row(
//           children: const [
//             Text(
//               'Travel Business',
//               style: TextStyle(
//                   color: Style.appbarfontcolor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30),
//             ),
//             Text(
//               '  PPP',
//               style: TextStyle(
//                   color: Style.appbarpagecolor,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30),
//             ),
//           ],
//         ),
//         backgroundColor: Style.appbarcolor,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 isTv(true);
//               },
//               icon: const Icon(Icons.tv)),
//           IconButton(
//               onPressed: () {
//                 isTv(false);
//               },
//               icon: const Icon(Icons.radio))
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(300.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CachedNetworkImage(imageUrl: bannerimg),
//               Container(
//                 alignment: Alignment.center,
//                 height: 35,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(color: Style.backgroundcolor),
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       Color textcolor = Style.primaryfontcolor;
//                       if (maintabselectedindex == index) {
//                         textcolor = Style.selectedmaintabbarcolor;
//                       } else {
//                         textcolor = Style.primaryfontcolor;
//                       }
//                       return InkWell(
//                           onTap: (() {
//                             Get.off(maintab[index]["page"]);
//                           }),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Text(maintab[index]["name"].toString(),
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: textcolor,
//                                     fontSize: 18,
//                                     letterSpacing: 0.2,
//                                     fontFamily: 'Economica Bold',
//                                     fontWeight: FontWeight.w500)),
//                           ));
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return const VerticalDivider(
//                           thickness: 2,
//                           endIndent: 7,
//                           indent: 7,
//                           color: Style.verticaldividercolor);
//                     },
//                     itemCount: maintab.length),
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 30,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(color: Style.othertabbarcolor),
//                 child: ListView.separated(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       Color textcolor = Style.primaryfontcolor;
//                       if (othertabselectedindex == index) {
//                         textcolor = Style.selectedmaintabbarcolor;
//                       } else {
//                         textcolor = Style.primaryfontcolor;
//                       }
//                       return InkWell(
//                           onTap: (() {}),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 5),
//                             child: Text(othertab[index].toString(),
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: textcolor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Economica')),
//                           ));
//                     },
//                     separatorBuilder: (BuildContext context, int index) {
//                       return const VerticalDivider(
//                           thickness: 2,
//                           endIndent: 7,
//                           indent: 7,
//                           color: Style.verticaldividercolor);
//                     },
//                     itemCount: othertab.length),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: _remoteApi.getArticlesList(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return buildLoadingWidget();
//           } else {
//             return SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 35, right: 32, top: 20, bottom: 10),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Ram Path Gaman Marg',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Style.primaryfontcolor,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Economica'),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2),
//                           itemBuilder: (_, index) {
//                             return CachedNetworkImage(
//                               imageUrl: bannerimg,
//                             );
//                           },
//                           itemCount: 4,
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
