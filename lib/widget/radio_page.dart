import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_app/element/loader.dart';
// import 'package:rxdart/rxdart.dart';

class MyAudioPage extends StatefulWidget {
  final String url;
  final bool isRadio;
  const MyAudioPage({Key? key, required this.url, this.isRadio = false})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAudioPage> with WidgetsBindingObserver {
  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;

    await session.configure(const AudioSessionConfiguration.speech());
    if (widget.isRadio) {
      try {
        await Future.delayed(const Duration(seconds: 5));
        await player.setAudioSource(
          AudioSource.uri(
            Uri.parse(widget.url),
          ),
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error loading audio source: $e",
        );
      }
    }

    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      FlutterError('A stream error occurred: $e');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.

    player.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ControlButtons(
      player: player,
      url: widget.url,
      isRadio: widget.isRadio,
    );
  }
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;
  final String url;
  final bool isRadio;
  const ControlButtons({
    Key? key,
    required this.player,
    required this.url,
    this.isRadio = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    if (isRadio) {
      return Container(
        height: 230,
        width: screenSize.width,
        alignment: Alignment.center,
        child: StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return SizedBox(

                  // width: 18.0,
                  height: 220.0,
                  child: buildLoadingWidget());
            } else if (playing != true) {
              return GestureDetector(
                onTap: player.play,
                child: SizedBox(
                    height: 230,
                    child: Stack(
                      children: [
                        const Image(image: AssetImage('assets/tv.jpeg')),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.1,
                            right: MediaQuery.of(context).size.width * 0.45,
                            child: const Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: Colors.white,
                            ))
                      ],
                    )),
              );
            } else if (processingState != ProcessingState.completed) {
              return Stack(
                children: [
                  Positioned(
                    left: 10,
                    bottom: 0,
                    child: Lottie.asset(
                      'assets/music.json',
                      height: 200,
                      width: Get.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 3,
                    top: -8,
                    child: IconButton(
                      icon: const Icon(
                        Icons.pause_rounded,
                        color: Colors.white,
                      ),
                      iconSize: 18.0,
                      onPressed: player.pause,
                    ),
                  ),
                ],
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay_rounded,
                  color: Colors.white,
                ),
                iconSize: 18.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
      );
    }

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: SelectableText(url.substring(40)),
        // ),
        Container(
          height: 60,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 28.0,
                    height: 28.0,
                    child: buildLoadingWidget());
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 38.0,
                  onPressed: () async {
                    try {
                      await player
                          .setAudioSource(
                            AudioSource.uri(
                              Uri.parse(
                                url,
                              ),
                            ),
                          )
                          .then((value) => player.play());
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: "Error loading audio source: $e",
                      );
                    }
                  },
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(
                    Icons.pause_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 38.0,
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.replay_rounded,
                    color: Colors.white,
                  ),
                  iconSize: 38.0,
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
