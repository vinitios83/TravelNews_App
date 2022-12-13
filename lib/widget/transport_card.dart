import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/utility/colors.dart';
import '../../../models/association_model.dart';

import '../screens/update_transport.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';
import 'transport_detail.dart';
import '../../../controller/b2b_controller.dart';
import '../../../models/deal_type.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/b2b_model.dart';

class TransportCard extends StatefulWidget {
  const TransportCard({
    Key? key,
    required this.transport,
    required this.org,
    required this.dealType,
    required this.userName,
    required this.password,
    required this.assId,
  }) : super(key: key);
  final Transport transport;
  final String org;
  final String userName;
  final String password;
  final DealType dealType;
  final String assId;

  @override
  State<TransportCard> createState() => _TransportCardState();
}

class _TransportCardState extends State<TransportCard> {
  final B2BController b2bController = Get.put(B2BController());

  @override
  Widget build(BuildContext context) {
    Widget myAction = Container();

    switch (widget.dealType) {
      case DealType.DEAL:
        myAction = IconButton(
          onPressed: () async {
            if (widget.userName == widget.transport.userid) {
              VxToast.show(context,
                  msg: 'Can\'t add your own deal in favorite');
            } else {
              await Apis.postFavDeals(
                assId: widget.assId,
                userid: widget.userName,
                password: widget.password,
                fId: widget.transport.id,
                mName: widget.transport.formname.replaceAll('module', ''),
              ).then((value) => VxToast.show(context, msg: '$value'));
            }
          },
          icon: const Icon(
            Icons.favorite_rounded,
            color: Colors.redAccent,
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
                            package: widget.transport.formname,
                            uniqueId: widget.transport.id)
                        .then(
                      (value) {
                        VxToast.show(context, msg: '$value');
                        if (value == 'Deal deleted successfully') {
                          b2bController.myListTransport
                              .remove(widget.transport);
                          if (b2bController.b2bListTransport
                              .contains(widget.transport)) {
                            b2bController.b2bListTransport
                                .remove(widget.transport);
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
                Get.to(
                  () => TransportUpdateScreen(
                    association: Association(
                      atype: '',
                      id: widget.assId,
                      imageUrl: '',
                      name: widget.org,
                    ),
                    username: widget.userName,
                    password: widget.password,
                    transport: widget.transport,
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ],
        );
        break;
      case DealType.Fav:
        myAction = IconButton(
          onPressed: () async {
            await b2bController
                .deleteFavDeals(
              userid: widget.userName,
              password: widget.password,
              uniqueId: widget.transport.id,
            )
                .then((value) {
              VxToast.show(context, msg: value);
              b2bController.fetchFavDeals(
                id: widget.assId,
                userid: widget.userName,
                password: widget.password,
              );
            });
          },
          icon: const Icon(
            CupertinoIcons.delete,
            color: Colors.red,
          ),
        );
        break;
      default:
        IconButton(
          onPressed: () async {
            await Apis.postFavDeals(
              assId: widget.assId,
              userid: widget.userName,
              password: widget.password,
              fId: widget.transport.id,
              mName: widget.transport.formname.replaceAll('module', ''),
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
                  widget.transport.createdt,
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
                        '${AssociationHelper.URL_LIST_OF_ASSOCIATION_CIRCLE}${widget.transport.assoname}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      widget.transport.dealName,
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
                onTap: () {
                  Get.to(
                    () => TransportDetailPage(
                      transport: widget.transport,
                    ),
                  );
                },
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
                      transport: widget.transport,
                    ),
                    PriceRowPerHour(transport: widget.transport),
                    PriceRowPerKM(transport: widget.transport)
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
    required this.transport,
  }) : super(key: key);

  final Transport transport;

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
          ('${transport.state}/${transport.city}'.length > 12)
              ? '${'${transport.state}/${transport.city}'.substring(0, 12)}...'
              : '${transport.state}/${transport.city}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class PriceRowPerHour extends StatelessWidget {
  const PriceRowPerHour({
    Key? key,
    required this.transport,
  }) : super(key: key);

  final Transport transport;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Rs. ${transport.costPerHour}',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ],
    );
  }
}

class PriceRowPerKM extends StatelessWidget {
  const PriceRowPerKM({
    Key? key,
    required this.transport,
  }) : super(key: key);

  final Transport transport;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Rs. ${transport.costPerKm}',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ],
    );
  }
}
