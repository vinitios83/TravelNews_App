import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/utility/colors.dart';

import '../models/newlist.dart';
import '../screens/news_details_page.dart';
import '../utility/constant.dart';
import 'package:intl/intl.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    Key? key,
    required this.index,
    required this.list,
    required this.onChanged,
    required this.isPlayTV,
  }) : super(key: key);

  final int index;
  final List<Hotnew> list;

  final ValueChanged<bool> onChanged;
  final bool isPlayTV;
  void _handleTap() {
    onChanged(false);
  }
int daysBetween(String from) {
     DateTime fromDate = DateFormat('M/d/yyyy').parse(from);
     DateTime to = DateTime.now();
   return (to.difference(fromDate).inHours).round();
  }
  @override
  Widget build(BuildContext context) {
    int hours = daysBetween(list[index].createdt.split(' ')[0]);
    bool isNew = (hours <= 48);
        // ('${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}' ==
        //     list[index].createdt.split(' ')[0]);
    return GestureDetector(
        onTap: (() {
          this._handleTap();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => NewsDetailPage(
                hotnew: list,
                index: index,
              ),
            ),
          );
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
                      Expanded(
                          flex: 33,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: list[index].image,
                                  height: 80,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Image.asset(
                                      AppConstants.fallBackLogo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  errorWidget: (context, url, _) => SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    width: 120,
                                    child: Image.asset(
                                      AppConstants.fallBackLogo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Badge(
                                  toAnimate: true,
                                  shape: BadgeShape.square,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
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
                          )),
                      VerticalDivider(
                        color: Colors.white,
                        width: 8.0,
                      ),
                      Expanded(
                        flex: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 80,
                              child: Text(
                                list[index].videoname,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Style.primaryfontcolor,
                                    fontFamily: 'Calibri Regular'),
                              ),
                            ),
                            Expanded(
                              flex: 15,
                              child: Text(
                                list[index].createdt,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Style.primaryfontcolor,
                                    fontFamily: 'Calibri Regular'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        width: 8.0,
                      ),
                      Icon(
                        color: Colors.black,
                        Icons.keyboard_arrow_right,
                        size: 18,
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
