import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/version/version_contoller.dart';
import 'package:travel_app/widget/marquee_view.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../models/yt_playlist.dart';
import '../../services/remote_api.dart';

import '../utility/constant.dart';
import '../widget/my_banners_ads.dart';

VersionController versionController = Get.put(VersionController());

YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(
  videoId: versionController.youtubedefault.value,
  params: const YoutubePlayerParams(
    enableJavaScript: true,
    showControls: true,
    showFullscreenButton: true,
    // autoPlay: false,
  ),
);

class YouTubeListPage extends StatefulWidget {
  const YouTubeListPage({Key? key}) : super(key: key);

  @override
  _YouTubeListPageState createState() => _YouTubeListPageState();
}

class _YouTubeListPageState extends State<YouTubeListPage> {
  final RemoteApi _remoteApi = RemoteApi();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //VxToast.show(context, msg: versionController.youtubedefault.value);
    return Scaffold(
      body: FutureBuilder<PlayList?>(
        future: _remoteApi.getPlayList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: buildLoadingWidget(),
            );
          } else {
            List<Newsbulletin> news = snapshot.data!.newsbulletin;
            List<Interview> interview = snapshot.data!.interview;
            return Scaffold(
              backgroundColor: Style.backgroundcolor,
              bottomNavigationBar: const MyBannerAds(),
              appBar: AppBar(
                title: Row(
                  children: const [
                    Text('Travel Business',
                        style: TextStyle(
                            color: Style.appbarfontcolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    SizedBox(width: 8),
                    Text(
                      'Views',
                      style: TextStyle(
                          color: Style.appbarpagecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.5),
                  child: Container(
                    height: 1.5,
                    color: Style.dividercolor,
                  ),
                ),
                backgroundColor: Style.appbarcolor,
                automaticallyImplyLeading: true,
              ),
              body: SafeArea(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Column(
                    children: [
                      Header(
                        initialId: snapshot.data!.featuredInterview,
                      ),
                      Container(
                        height: 1.5,
                        color: Style.dividercolor,
                      ),
                      MarqueeView(),
                      const Divider(
                  height: 8,
                  color: Colors.white,
                ),
                      Expanded(
                        child: ShowData(
                          news: news,
                          interview: interview,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ShowData extends StatelessWidget {
  const ShowData({
    Key? key,
    required List<Newsbulletin> news,
    required List<Interview> interview,
  })  : _news = news,
        _interview = interview,
        super(key: key);

  final List<Newsbulletin> _news;
  final List<Interview> _interview;

  @override
  Widget build(BuildContext context) {
    return Videos(mylist: _news, mylist1: _interview);
  }
}

class Videos extends StatelessWidget {
  const Videos({
    Key? key,
    required this.mylist,
    required this.mylist1,
  }) : super(key: key);

  final List<Newsbulletin> mylist;
  final List<Interview> mylist1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      // cacheExtent: widget.mylist.length.toDouble(),
      itemCount: mylist.length,
      itemBuilder: (context, index) {
        Newsbulletin newsbulletin = mylist[index];
        String title = newsbulletin.videotitle;
        print('News Title === $title');
        
        return YouTubeTile(
          id: newsbulletin.video,
          title: newsbulletin.videotitle,
          date: newsbulletin.videodt,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        Interview interview = mylist1[index];
        return YouTubeTile(
          id: interview.featuredInterview,
          title: interview.interviewname,
          date: interview.featuredInterviewdate,
        );
      },
    );
  }
}

class YouTubeTile extends StatelessWidget {
  const YouTubeTile({
    Key? key,
    required this.id,
    required this.title,
    required this.date,
  }) : super(key: key);

  final String id;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '${AppConstants.youTubeImageBaseUrl}$id/0.jpg';
    return GestureDetector(
      onTap: () {
        _controller.loadVideoById(videoId: id);
      },
      child: Stack(
        children: [
          Container(
            // margin: const EdgeInsets.symmetric(vertical: 1.2),
            decoration: BoxDecoration(
              color: Style.backgroundcolor,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.values[4],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 3),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 70,
                        width: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          height: 65,
                          width: 120,
                          child: Image.asset(
                            AppConstants.fallBackLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        errorWidget: (context, url, _) => SizedBox(
                          height: 65,
                          width: 120,
                          child: Image.asset(
                            AppConstants.fallBackLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - (170),
                      child: Container(
                        child: Flexible(
                         child: Text(
                          '$title',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                        ), 
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right,size: 18,),
                  ],
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width - (60),
                //   child: Text(
                //           '$date',
                //           overflow: TextOverflow.ellipsis,
                //           maxLines: 1,
                //           textAlign: TextAlign.end,
                //           style: const TextStyle(
                //               fontSize: 12,
                //               fontWeight: FontWeight.normal,
                //               color: Style.primaryfontcolor,
                //               fontFamily: 'Calibri Regular'),
                //         ),
                // ),
                const Divider(
                  thickness: 2,
                  color: Style.dividercolor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.initialId,
  }) : super(key: key);
  final String initialId;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    startPlayer();
    super.initState();
  }

  Future<void> startPlayer() async {
    await Future.delayed(const Duration(seconds: 5));
    _controller.loadVideoById(videoId: widget.initialId);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerIFrame(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
