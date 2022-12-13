import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class LiveTvPage extends StatefulWidget {
  const LiveTvPage({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;
  @override
  _LiveTvPageState createState() => _LiveTvPageState();
}

class _LiveTvPageState extends State<LiveTvPage> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
      showPlaceholderUntilPlay: true,
      placeholder: Image(image: AssetImage('assets/tv.jpeg')),
      
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      autoDetectFullscreenDeviceOrientation: true,
      autoPlay: false,
      allowedScreenSleep: false,
      autoDispose: true,
      expandToFill: true,
      fullScreenByDefault: false,
    );
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.url,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }
}
