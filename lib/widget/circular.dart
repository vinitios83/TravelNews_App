import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/circular_controller.dart';
import '../../models/circular.dart';
import 'my_banners_ads.dart';

class CircularUpdateScreen extends StatefulWidget {
  const CircularUpdateScreen({
    Key? key,
    required this.aId,
    required this.index,
  }) : super(key: key);
  final int aId;
  final int index;

  @override
  State<CircularUpdateScreen> createState() => _CircularUpdateScreenState();
}

class _CircularUpdateScreenState extends State<CircularUpdateScreen> {
  late int myIndex;
  late String title;
  final CircularController circularController = Get.put(CircularController());
  final controller = PageController(initialPage: 0);
  @override
  void initState() {
    myIndex = widget.index;
    title = (myIndex == 0) ? 'Circulars' : 'Updates';
    circularController.fetchCircular(aId: '${widget.aId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (circularController.isLoading.value) {
          return Scaffold(
            body: Center(child: buildLoadingWidget()),
          );
        } else {
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: const MyBannerAds(),
              appBar: AppBar(
                backgroundColor: Style.appbarcolor,
                title: Text(title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              body: Column(
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            const BoxDecoration(color: Style.othertabbarcolor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: (() {
                                  controller.animateToPage(0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut);
                                }),
                                child: const Text('Circulars',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 22,
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
                                child: const Text('Updates',
                                    style: TextStyle(
                                        color: Style.tabbarfontcolor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          controller: controller,
                          children: [
                             CircularList(circular: circularController.circular),
                             CircularList(circular: circularController.updates),
                          ],
                        )),
                    ],
                  )
            ),
          );
        }
      },
    );
  }
}

class CircularList extends StatelessWidget {
  const CircularList({
    Key? key,
    required this.circular,
  }) : super(key: key);
  final List<Circular> circular;

  @override
  Widget build(BuildContext context) {
    if (circular.isEmpty) {
      return const Center(
        child: Text('NO Data'),
      );
    } else {
      return ListView.builder(
        itemCount: circular.length,
        itemBuilder: (context, index) {
          return CircularTile(
            list: circular,
            index: index,
          );
        },
      );
    }
  }
}

class CircularTile extends StatelessWidget {
  const CircularTile({
    Key? key,
    required this.index,
    required this.list,
  }) : super(key: key);

  final int index;
  final List<Circular> list;

  @override
  Widget build(BuildContext context) {
    bool isNew =
        ('${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}' ==
            list[index].date.split(' ')[0]);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => CircularDetailPage(
            circular: list,
            index: index,
          ),
        ),
      ),
      child: ListTile(
        leading: SizedBox(width: 100.0,
          child: Text(
                      list[index].date,
                      style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                    ),),
            title: Text(
                      list[index].title,
                      style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                    ),
            trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
          ),
      // Container(
      //       margin: const EdgeInsets.symmetric(vertical: 1.2),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.circular(2),
      //       ),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(right: 10),
      //             child: Column(
      //               children: [
      //                 Text(
      //                   list[index].date.split(" ").elementAt(0),
      //                   style: const TextStyle(
      //                     fontSize: 14,
      //                     fontWeight: FontWeight.bold,
      //                     color: Style.primaryfontcolor,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 4),
      //                 Row(
      //                   children: [
      //                     Text(
      //                       list[index].date.split(" ").elementAt(1),
      //                       style: const TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.bold,
      //                         color: Style.primaryfontcolor,
      //                       ),
      //                     ),
      //                     const WidthBox(3),
      //                     Text(
      //                       list[index].date.split(" ").elementAt(2),
      //                       style: const TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.bold,
      //                         color: Style.primaryfontcolor,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //               child: Flexible(child: Text(
      //                 list[index].title,
      //                 style: const TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w400,
      //                         color: Style.primaryfontcolor,
      //                         fontFamily: 'Calibri Regular'),
      //               ),),
      //             ),
      //           const Icon(
      //             Icons.arrow_forward_ios,
      //             size: 18,
      //           ),
      //         ],
      //       ),
      //     )
    );
  }
}

class CircularDetailPage extends StatefulWidget {
  const CircularDetailPage({
    Key? key,
    required this.circular,
    required this.index,
  }) : super(key: key);
  final List<Circular> circular;
  final int index;

  @override
  State<CircularDetailPage> createState() =>
      // ignore: no_logic_in_create_state
      _CircularDetailPageState(currentIndex: index);
}

class _CircularDetailPageState extends State<CircularDetailPage> {
  _CircularDetailPageState({required this.currentIndex});
  int currentIndex;
  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: widget.index);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.appbarcolor,
        title: const Text('Circular And Updates',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Style.appbarfontcolor)),
      ),
      body: PageView.builder(
        itemCount: widget.circular.length,
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: HtmlWidget(
                    widget.circular[index].text
                        .replaceAll('GLOBALBREAK', '<br>'),
                    onTapUrl: (url) {
                      _launchURL(url);
                      return true;
                    },
                    textStyle: const TextStyle(
                        fontSize: 17,
                        height: 1.2,
                        letterSpacing: 0.2,
                        color: Style.primaryfontcolor,
                        fontFamily: 'Calibri Regular'),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}