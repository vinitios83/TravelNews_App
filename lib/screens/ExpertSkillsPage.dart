import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/utility/colors.dart';
import 'package:travel_app/models/CampusDataModel.dart';
import '../services/remote_api.dart';
import '../utility/constant.dart';
import 'package:get/get.dart';
import 'package:travel_app/widget/live_tv.dart';
import 'package:travel_app/screens/YouTubePlayerPage.dart';
import '../widget/my_banners_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertSkillsPage extends StatefulWidget {
  const ExpertSkillsPage({Key? key}) : super(key: key);

  @override
  State<ExpertSkillsPage> createState() => _ExpertSkillsPageState();
}

class _ExpertSkillsPageState extends State<ExpertSkillsPage>
    with SingleTickerProviderStateMixin {
  final RemoteApi _remoteApi = RemoteApi();
  List<Course> expertSkillList = [];
  var isCallingAPI = true;

  @override
  void initState() {
    super.initState();
    fetchExpertSkllList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchExpertSkllList() async {
    await RemoteApi().getExpertSkillList().then((value) => {
          expertSkillList = value?.courseList ?? [],
          this.setState(() {
            isCallingAPI = false;
          })
        });
  }
_launchURL(String strURL) async {
  final uri = Uri.parse(strURL);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $strURL';
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.backgroundcolor,
        appBar: AppBar(
          backgroundColor: Style.appbarcolor,
          automaticallyImplyLeading: true,
          title: Row(
            children: const [
              Text('Expert Skills',
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
        body: Padding(
          padding: EdgeInsets.all(10),
          child: (expertSkillList.length == 0)
              ? nullui()
              : Expanded(
                  child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemCount: this.expertSkillList.length,
                  itemBuilder: (context, index) {
                    String title = this.expertSkillList[index].name ?? "";
                    String detail = this.expertSkillList[index].link ?? "";
                    return GestureDetector(
                        onTap: (() {
                          this._launchURL(detail);
                        }),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Container(
                            height: 110,
                            child: Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                (80),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Style.primaryfontcolor,
                                                  fontFamily:
                                                      'Calibri Regular'),
                                            ),
                                            Text(
                                              detail,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.blue,
                                                  fontFamily:
                                                      'Calibri Regular'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ));
                  },
                )),
        ));
  }

  Widget nullui() {
    if (isCallingAPI == true) {
      return buildLoadingWidget();
    } else {
      return const Center(
        child: Text(
          "Nothing to show",
          style: TextStyle(
              fontSize: 18,
              color: Style.primaryfontcolor,
              fontWeight: FontWeight.w500,
              fontFamily: 'Economica'),
        ),
      );
    }
  }
}
