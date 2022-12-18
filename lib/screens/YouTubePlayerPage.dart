// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';
import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/models/CampusDataModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../widget/my_banners_ads.dart';

class YouTubePlayerPage extends StatefulWidget {
  const YouTubePlayerPage({Key? key, required this.videoDetail})
      : super(key: key);
  final CampusCategory videoDetail;
  @override
  State<YouTubePlayerPage> createState() => _YouTubePlayerPageState();
}

class _YouTubePlayerPageState extends State<YouTubePlayerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.videoDetail.heading ?? "";
    String detail = widget.videoDetail.detail ?? "";
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Style.appbarcolor,
          automaticallyImplyLeading: true,
          title: Row(
            children: const [
              Text('Travel Business',
                  style: TextStyle(
                      color: Style.appbarfontcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30)),
              SizedBox(width: 8),
              Text(
                'CAMPUS',
                style: TextStyle(
                    color: Style.appbarpagecolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )
            ],
          ),
        ),
        bottomNavigationBar: const MyBannerAds(),
        body: YouTubePlayer(videoDetail: widget.videoDetail));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class YouTubePlayer extends StatefulWidget {
  const YouTubePlayer({Key? key, required this.videoDetail}) : super(key: key);
  final CampusCategory videoDetail;
  @override
  State<YouTubePlayer> createState() => _YouTubePlayerState();
}

class _YouTubePlayerState extends State<YouTubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    )
      ..onInit = () {
        _controller.loadVideoByUrl(
            mediaContentUrl: widget.videoDetail.video ?? "");
      }
      ..onFullscreenChange = (isFullScreen) {
        log('${isFullScreen ? 'Entered' : 'Exited'} Fullscreen.');
      };
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(body: player);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pauseVideo();
    _controller.close();
  }
}
