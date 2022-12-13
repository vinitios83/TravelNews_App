import 'package:flutter/cupertino.dart';
import 'package:travel_app/utility/colors.dart';

import '../utility/marquee.dart';

class MyMarquee extends StatelessWidget {
  const MyMarquee({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    String doc = removeAllHtmlTags(
      text.replaceAll('GLOBALBREAK', ' ').replaceAll('&nbsp;', ' '),
    );
    return Container(
      color: Style.marqueebackgroundcolor,
      height: 35,
      child: Center(
        child: Marquee(
          text: doc,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Style.marqueefontcolor),
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          blankSpace: 20.0,
          velocity: 30.0,
          startPadding: 10.0,
        ),
      ),
    );
  }
}
