import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlView extends StatelessWidget {
  const HtmlView({
    Key? key,
    required this.strHtml,
  }) : super(key: key);
  final String strHtml;

  @override
  Widget build(BuildContext context) {
    return new Html(
         data: strHtml,
       );
  }
}