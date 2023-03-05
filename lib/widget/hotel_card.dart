import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/association_model.dart';

import '../../../controller/b2b_controller.dart';
import '../../../models/deal_type.dart';
import 'package:velocity_x/velocity_x.dart';

import '../screens/update_hotel.dart';
import '../screens/update_package.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';
import '../utility/colors.dart';
import 'hotel_details.dart';

import '../../../models/b2b_model.dart';

class HotelCard extends StatefulWidget {
  const HotelCard({
    Key? key,
    required this.hotel,
    required this.org,
    required this.dealType,
    required this.userName,
    required this.password,
    required this.assId,
  }) : super(key: key);
  final Hotel hotel;
  final String org;
  final String userName;
  final String password;
  final DealType dealType;
  final String assId;

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  final B2BController b2bController = Get.put(B2BController());

  @override
  void initState() {
    super.initState();
    // b2bController.fetchB2BDeals();
  }

  @override
  Widget build(BuildContext context) {
    Widget myAction = Container();

    switch (widget.dealType) {
      case DealType.DEAL:
        myAction = IconButton(
          onPressed: () async {
            if (widget.userName == widget.hotel.userid) {
              VxToast.show(context,
                  msg: 'Can\'t add your own deal in favorite');
            } else {
              await Apis.postFavDeals(
                      assId: widget.assId,
                      userid: widget.userName,
                      password: widget.password,
                      fId: widget.hotel.id,
                      mName: (widget.hotel.formname.contains('modules'))
                          ? widget.hotel.formname.replaceAll('modules', '')
                          : widget.hotel.formname.replaceAll('module', ''))
                  .then((value) => VxToast.show(context, msg: '$value'));
            }
          },
          icon: const Icon(
            Icons.favorite_rounded,
            color: Colors.redAccent,
          ),
        );
        break;
      case DealType.Fav:
        myAction = IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: 'Confirm Delete?',
              titleStyle: const TextStyle(color: Colors.red),
              middleText:
                  'This Operation will remove this deal from your favourite deals!',
              textConfirm: 'Delete',
              confirmTextColor: Colors.white,
              buttonColor: Style.appbarcolor,
              // cancelTextColor: AppTheme.kPrimaryColor,
              onConfirm: () async {
                await b2bController
                    .deleteFavDeals(
                  userid: widget.userName,
                  password: widget.password,
                  uniqueId: widget.hotel.id,
                )
                    .then((value) {
                  VxToast.show(context, msg: value);
                  b2bController.fetchFavDeals(
                    id: widget.assId,
                    userid: widget.userName,
                    password: widget.password,
                  );
                  Navigator.of(context).pop();
                  return;
                });
              },
              onCancel: () {
                return;
              },
            );
          },
          icon: const Icon(
            CupertinoIcons.delete,
            color: Colors.red,
          ),
        );
        break;
      case DealType.MYDEAL:
        myAction = Row(
          children: [
            IconButton(
              onPressed: () async {
                Get.defaultDialog(
                  title: 'Confirm Delete?',
                  titleStyle: const TextStyle(color: Colors.red),
                  middleText: 'This Operation is irreversivle.',
                  textConfirm: 'Delete',
                  confirmTextColor: Colors.white,
                  // buttonColor: AppTheme.kPrimaryColor,
                  // cancelTextColor: AppTheme.kPrimaryColor,
                  onConfirm: () async {
                    await Apis.deleateDeals(
                      username: widget.userName,
                      password: widget.password,
                      package: widget.hotel.formname,
                      uniqueId: widget.hotel.id,
                    ).then(
                      (value) {
                        VxToast.show(context, msg: '$value');
                        if (value == 'Deal deleted successfully') {
                          if (widget.hotel.formname.contains('hotel')) {
                            b2bController.myListHotel.remove(widget.hotel);
                            if (b2bController.b2bListHotel
                                .contains(widget.hotel)) {
                              b2bController.b2bListHotel.remove(widget.hotel);
                            }
                          } else {
                            b2bController.myListPackages.remove(widget.hotel);
                            if (b2bController.b2bListPackages
                                .contains(widget.hotel)) {
                              b2bController.b2bListPackages
                                  .remove(widget.hotel);
                            }
                          }
                        }

                        Get.back();
                      },
                    );
                  },
                  onCancel: () {
                    return;
                  },
                );
              },
              icon: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.redAccent,
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.hotel.formname.contains('hotel')) {
                  Get.to(
                    () => UpdateHotelScreen(
                      association: Association(
                        name: widget.hotel.assoname,
                        id: widget.assId,
                        atype: '',
                        imageUrl:
                            '${AssociationHelper.URL_LIST_OF_ASSOCIATION_CIRCLE}${widget.hotel.assoname}.png',
                      ),
                      hotel: widget.hotel,
                      username: widget.userName,
                      password: widget.password,
                    ),
                  );
                } else {
                  Get.to(
                    () => PackageUpdareScreen(
                      association: Association(
                        name: widget.hotel.assoname,
                        id: widget.assId,
                        atype: '',
                        imageUrl:
                            '${AssociationHelper.URL_LIST_OF_ASSOCIATION_CIRCLE}${widget.hotel.assoname}.png',
                      ),
                      hotel: widget.hotel,
                      username: widget.userName,
                      password: widget.password,
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ],
        );
        break;
      default:
        IconButton(
          onPressed: () async {
            await Apis.postFavDeals(
              assId: widget.assId,
              userid: widget.userName,
              password: widget.password,
              fId: widget.hotel.id,
              mName: widget.hotel.formname.replaceAll('module', ''),
            ).then((value) => VxToast.show(context, msg: '$value'));
          },
          icon: const Icon(
            Icons.favorite_rounded,
            color: Colors.redAccent,
          ),
        );
    }

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4.0,
                spreadRadius: 1.0,
                color: Style.appbarcolor,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                ),
                alignment: Alignment.centerRight,
                child: Text(
                  widget.hotel.createdt,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.network(
                        '${AssociationHelper.URL_LIST_OF_ASSOCIATION_CIRCLE}${widget.hotel.assoname}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      widget.hotel.dealName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.05,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => Get.to(
                  () => HotelDetailsPage(
                    hotel: widget.hotel,
                    org: widget.org,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/read_more.png',
                      height: 30,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Style.appbarcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CityRow(
                      hotel: widget.hotel,
                    ),
                    PriceRow(
                      hotel: widget.hotel,
                      isPrivate: widget.assId != '12',
                    ),
                    RatingRow(hotel: widget.hotel)
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          left: 10,
          child: myAction,
        ),
      ],
    );
  }
}

class CityRow extends StatelessWidget {
  const CityRow({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: Colors.white,
          size: 18,
        ),
        const WidthBox(2),
        Text(
          ('${hotel.state}/${hotel.city}'.length > 12)
              ? '${'${hotel.state}/${hotel.city}'.substring(0, 12)}...'
              : '${hotel.state}/${hotel.city}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class PriceRow extends StatelessWidget {
  const PriceRow({
    Key? key,
    required this.hotel,
    this.isPrivate = true,
  }) : super(key: key);

  final Hotel hotel;
  final bool isPrivate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (isPrivate)
              ? 'Rs. ${hotel.dealPrivatePrice}'
              : 'Rs. ${hotel.dealPublicPrice}',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ],
    );
  }
}

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    double value = double.parse(hotel.dealHotelCategory) + 2;
    // return Text(value.toString());
    return VxRating(
      onRatingUpdate: (_) {},
      count: 5,
      isSelectable: false,
      selectionColor: Colors.yellow,
      value: value,
      maxRating: 5,
      size: 18,
    );
    // return Center(
    //   child: RatingStars(
    //     value: value,
    //     onValueChanged: (v) {},
    //     starBuilder: (index, color) => Icon(
    //       Icons.star_rounded,
    //       color: color,
    //     ),
    //     starCount: 5,
    //     starSize: 24,
    //     maxValue: 5,
    //     starSpacing: 2,
    //     maxValueVisibility: true,
    //     valueLabelVisibility: false,
    //     starOffColor: const Color(0xffe7e8ea),
    //     starColor: Colors.yellow,
    //   ),
    // );
  }
}
