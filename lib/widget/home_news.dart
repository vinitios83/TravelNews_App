
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utility/colors.dart';

import '../models/newlist.dart';
import '../screens/news_details_page.dart';
import '../utility/constant.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    Key? key,
    required this.index,
    required this.list,
  }) : super(key: key);

  final int index;
  final List<Hotnew> list;

  @override
  Widget build(BuildContext context) {
    bool isNew =
        ('${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}' ==
            list[index].createdt.split(' ')[0]);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => NewsDetailPage(
            hotnew: list,
            index: index,
          ),
        ),
      ),
      child: Stack(
        children: [
          Container(
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
                        imageUrl: list[index].image,
                        height: 70,
                        width: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Image.asset(
                            AppConstants.fallBackLogo,
                            fit: BoxFit.cover,
                          ),
                        ),
                        errorWidget: (context, url, _) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
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
                          list[index].videoname,
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
                Container(
                  width: MediaQuery.of(context).size.width - (60),
                  child: Text(
                          list[index].createdt,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: Style.primaryfontcolor,
                              fontFamily: 'Calibri Regular'),
                        ),
                ),
                const Divider(
                  thickness: 2,
                  color: Style.dividercolor,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Badge(
              toAnimate: true,
              shape: BadgeShape.square,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              showBadge: isNew,
              animationType: BadgeAnimationType.scale,
              badgeColor: Colors.red,
              borderRadius: BorderRadius.circular(0),
              badgeContent: const Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
