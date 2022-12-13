import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/association_model.dart';

import '../screens/member_list.dart';
import '../utility/colors.dart';
import 'my_banners_ads.dart';

import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  const CommonWebView({
    Key? key,
    required this.url,
    this.association,
    this.userName,
    this.password,
  }) : super(key: key);
  final String url;
  final Association? association;
  final String? userName;
  final String? password;
  @override
  CommonWebViewState createState() => CommonWebViewState();
}

class CommonWebViewState extends State<CommonWebView> {
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundcolor,
      bottomNavigationBar: const MyBannerAds(),
      appBar: AppBar(
        backgroundColor: Style.appbarcolor,
        title: const Text('About',
            style: TextStyle(
                color: Style.appbarfontcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        actions: [
          (widget.association != null)
              ? IconButton(
                  onPressed: () => Get.to(
                    () => MemberListPage(
                      association: widget.association!,
                      userName: widget.userName!,
                      password: widget.password!,
                    ),
                  ),
                  icon: const Icon(
                    Icons.person_search,
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        allowsInlineMediaPlayback: true,
        onPageFinished: pageFinishedLoading,
      ),
    );
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }
}
