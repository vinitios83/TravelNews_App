import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:travel_app/utility/colors.dart';
import '../models/newlist.dart';

import '../widget/my_banners_ads.dart';
import '../widget/radio_page.dart';

class NewsDetailPage extends StatefulWidget {
  const NewsDetailPage({
    Key? key,
    required this.hotnew,
    required this.index,
  }) : super(key: key);
  final List<Hotnew> hotnew;
  final int index;

  @override
  State<NewsDetailPage> createState() =>
      // ignore: no_logic_in_create_state
      _NewsDetailPageState(currentIndex: index);
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  _NewsDetailPageState({required this.currentIndex});
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: widget.index);
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        backgroundColor: Style.appbarcolor,
        title: const Text(
          'News',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Style.appbarfontcolor),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: Visibility(
          visible: (widget.hotnew[currentIndex].audio != ''),
          maintainState: true,
          child: MyAudioPage(
            url: widget.hotnew[currentIndex].audio,
            // key: ValueKey(widget.hotnew[currentIndex].audio),
          ),
        ),
      ),
      body: PageView.builder(
        itemCount: widget.hotnew.length,
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
                Card(
                  elevation: 4.0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl: widget.hotnew[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text(
                          widget.hotnew[index].videoname,
                          style: const TextStyle(
                              fontSize: 17,
                              height: 1.2,
                              letterSpacing: 0.2,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    '${widget.hotnew[index].newsby} | ${widget.hotnew[index].createdt}',
                    style: const TextStyle(
                        fontSize: 20,
                        height: 1.2,
                        letterSpacing: 0.2,
                        color: Style.primaryfontcolor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: HtmlWidget(
                    widget.hotnew[index].detail
                        .replaceAll('GLOBALBREAK', '<br>'),
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
