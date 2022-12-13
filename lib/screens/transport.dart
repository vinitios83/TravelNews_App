import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/b2b_controller.dart';
import '../../models/deal_type.dart';
import '../models/association_model.dart';
import '../widget/transport_card.dart';

class B2BTransport extends StatelessWidget {
  B2BTransport({
    Key? key,
    required this.org,
    required this.username,
    required this.password,
  }) : super(key: key);
  final Association org;
  final String username;
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
      //               index: 2,
      //               association: org,
      //               username: username,
      //               password: password,
      //             ),
      //           );
      //         },
      //       ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: b2bController.b2bListTransport.length,
            itemBuilder: (context, index) {
              if (org.name == 'FAITH') {
                return TransportCard(
                  transport: b2bController.b2bListTransport[index],
                  org: org.name,
                  dealType: DealType.DEAL,
                  userName: username,
                  password: password,
                  assId: org.id,
                );
              } else {
                if (org.name ==
                    b2bController.b2bListTransport[index].assoname) {
                  return Obx(() {
                    bool isfav = (b2bController.favListTransport
                            .contains(b2bController.b2bListTransport[index]))
                        ? true
                        : false;
                    if (isfav == false) {
                      return TransportCard(
                        transport: b2bController.b2bListTransport[index],
                        org: org.name,
                        dealType: DealType.DEAL,
                        userName: username,
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
