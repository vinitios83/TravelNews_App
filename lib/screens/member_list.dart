import 'package:cached_network_image/cached_network_image.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/element/loader.dart';
import 'package:travel_app/utility/colors.dart';

import '../../controller/association_members_controller.dart';
import '../../models/association_members.dart';
import '../../models/association_model.dart';

import 'package:velocity_x/velocity_x.dart';

import '../utility/search_page.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({
    Key? key,
    required this.association,
    required this.userName,
    required this.password,
  }) : super(key: key);
  final Association association;
  final String userName;
  final String password;

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  final AssociationMemberController controller =
      Get.put(AssociationMemberController());
  late int myIndex;
  late String title;
  @override
  void initState() {
    myIndex = 0;
    title =
        (myIndex == 0) ? 'Board (MC)'.toUpperCase() : 'Chapters'.toUpperCase();
    controller.fetchMemberList(
      aUserName: widget.userName,
      aUserPassword: widget.password,
      aName: widget.association.name,
      aId: widget.association.id,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(
        text: 'Board (MC)'.toUpperCase(),
      ),
      Tab(
        text: 'Chapters'.toUpperCase(),
      ),
    ];
    return Obx(
      () {
        if (controller.isLoading.value) {
          return Scaffold(
            body: Center(child: buildLoadingWidget()),
          );
        } else {
          return Scaffold(
            backgroundColor: Style.backgroundcolor,
            appBar: AppBar(
              backgroundColor: Style.appbarcolor,
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Style.appbarfontcolor),
              ),
              actions: [
                IconButton(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: SearchPage<ChapterChairman>(
                      items: controller.members,
                      searchLabel: 'Search for Members',
                      suggestion: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Text(
                            'Search For The Members across Name , Company name , email address.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      failure: const Center(
                        child: Text('No Members found :('),
                      ),
                      filter: (member) => [
                        member.mname,
                        member.cname,
                        member.email1,
                        member.email2,
                      ],
                      builder: (chapterChairman) => MemberCard(
                        chapterChairman: chapterChairman,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.search_rounded),
                ),
              ],
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ContainedTabBarView(
                tabs: tabs,
                initialIndex: 0,
                onChange: (ind) {
                  setState(() {
                    myIndex = ind;
                    title = (myIndex == 0)
                        ? 'Board (MC)'.toUpperCase()
                        : 'Chapters'.toUpperCase();
                  });
                },
                callOnChangeWhileIndexIsChanging: true,
                tabBarProperties: TabBarProperties(
                  height: 45,
                  background: Container(
                    color: const Color(0xff0d0101),
                  ),
                  indicatorColor: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                    wordSpacing: 0.4,
                    fontSize: 14,
                  ),
                  margin: EdgeInsets.zero,
                  isScrollable: false,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  position: TabBarPosition.top,
                ),
                views: [
                  MemberList(chapterChairman: controller.directors),
                  MemberList(chapterChairman: controller.chapterChairman),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class MemberList extends StatelessWidget {
  const MemberList({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);
  final List<ChapterChairman> chapterChairman;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chapterChairman.length,
      itemBuilder: (context, index) {
        return MemberCard(chapterChairman: chapterChairman[index]);
      },
    );
  }
}

class MemberCard extends StatelessWidget {
  const MemberCard({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);

  final ChapterChairman chapterChairman;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: (chapterChairman.photo != "")
                ? Container(
                    margin: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                    child: CachedNetworkImage(
                      imageUrl: chapterChairman.photo,
                      height: 70,
                      width: 60,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 70,
                        width: 60,
                        margin: const EdgeInsets.all(6),
                        // child:
                        // Image.asset(AssetsHelper.memberPlaceholder),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : Container(
                    height: 70,
                    width: 60,
                    margin: const EdgeInsets.all(6),
                    // child: Image.asset(AssetsHelper.memberPlaceholder),
                  ),
          ),
          title: Text(
            chapterChairman.mname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(chapterChairman.cname),
          trailing:MyIconRow(
            chapterChairman: chapterChairman,
          ),
          ),
    );
  }
}

class MyIconRow extends StatelessWidget {
  const MyIconRow({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);
  final ChapterChairman chapterChairman;

  @override
  Widget build(BuildContext context) {
    return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Select Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.email1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.email2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      );
                }, icon: const Icon(Icons.mail)),
                IconButton(onPressed: () {
                  Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Phone Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.phone,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      );
                }, icon: const Icon(Icons.phone)),
                IconButton(onPressed: () {
                  Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    chapterChairman.mname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.address1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.address2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      );
                }, icon: Image.asset("assets/location.png",height: 60,width: 60)),
              ],
            );
    
    
    
    
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);

  final ChapterChairman chapterChairman;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    chapterChairman.mname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.address1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.address2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      ),
      // child: Image.asset(AssetsHelper.location),
    );
  }
}

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);

  final ChapterChairman chapterChairman;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Phone Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.phone,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      ),
      // child: Image.asset(AssetsHelper.phone),
    );
  }
}

class MailIcon extends StatelessWidget {
  const MailIcon({
    Key? key,
    required this.chapterChairman,
  }) : super(key: key);

  final ChapterChairman chapterChairman;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    'Select Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.email1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SelectableText(
                  chapterChairman.email2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 2.0,
      ),
      // child: Image.asset(AssetsHelper.email),
    );
  }
}
