import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/b2b_controller.dart';
import '../../models/deal_type.dart';
import '../models/association_model.dart';
import '../widget/hotel_card.dart';

class B2BHotel extends StatelessWidget {
  B2BHotel({
    Key? key,
    required this.org,
    required this.userName,
    required this.password,
    required this.dealType,
  }) : super(key: key);

  final Association org;
  final DealType dealType;
  final String userName;
  final String password;
  final B2BController b2bController = Get.put(B2BController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: (org.name == 'FAITH')
      //     ? null
      //     : FloatingActionButton(
      //         child: const Icon(Icons.add),
      //         backgroundColor: const Color(0xff0d0101),
      //         onPressed: () {
      //           Get.to(
      //             () => CreateDealsScreen(
      //               index: 1,
      //               association: org,
      //               username: userName,
      //               password: password,
      //             ),
      //           );
      //         },
      //       ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: b2bController.b2bListHotel.length,
            itemBuilder: (context, index) {
              if (org.name == 'FAITH') {
                return HotelCard(
                  hotel: b2bController.b2bListHotel[index],
                  org: org.name,
                  dealType: dealType,
                  userName: userName,
                  password: password,
                  assId: org.id,
                );
              } else {
                if (org.name == b2bController.b2bListHotel[index].assoname) {
                  return Obx(() {
                    bool isfav = (b2bController.favListHotel
                            .contains(b2bController.b2bListHotel[index]))
                        ? true
                        : false;
                    if (isfav == false) {
                      return HotelCard(
                        hotel: b2bController.b2bListHotel[index],
                        org: org.name,
                        dealType: dealType,
                        userName: userName,
                        password: password,
                        assId: org.id,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  });
                } else {
                  return const SizedBox.shrink();
                }
              }
            },
          );
        },
      ),
    );
  }
}
