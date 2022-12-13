import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/b2b_controller.dart';
import '../../models/deal_type.dart';
import '../models/association_model.dart';
import '../widget/hotel_card.dart';

class B2BPackage extends StatelessWidget {
  B2BPackage({
    Key? key,
    required this.org,
    required this.dealType,
    required this.userName,
    required this.password,
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
      //         backgroundColor: Color(0xff0d0101),
      //         onPressed: () {
      //           Get.to(
      //             () => CreateDealsScreen(
      //               index: 0,
      //               association: org,
      //               username: userName,
      //               password: password,
      //             ),
      //           );
      //         },
      //       ),
      body: (b2bController.b2bListPackages.isEmpty)
          ? const Center(
              child: Text('No Data'),
            )
          : Obx(
              () {
                return ListView.builder(
                  itemCount: b2bController.b2bListPackages.length,
                  itemBuilder: (context, index) {
                    if (org.name == 'FAITH') {
                      return HotelCard(
                        hotel: b2bController.b2bListPackages[index],
                        org: org.name,
                        dealType: dealType,
                        userName: userName,
                        password: password,
                        assId: org.id,
                      );
                    } else {
                      if (org.name ==
                          b2bController.b2bListPackages[index].assoname) {
                        return Obx(() {
                          bool isfav = false;
                          for (var item in b2bController.favListPackages) {
                            if (item.id ==
                                b2bController.b2bListPackages[index].id) {
                              isfav = true;
                              break;
                            }
                          }
                          if (isfav == false) {
                            return HotelCard(
                              hotel: b2bController.b2bListPackages[index],
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
