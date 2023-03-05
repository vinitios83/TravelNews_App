import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utility/constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                // color: AppTheme.kPrimaryColor,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(35),
                    image: const DecorationImage(
                      image: AssetImage(
                        AppConstants.applogo,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Travel World Online',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Calibri Regular',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  'info@travelworldonline.in',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Calibri Regular',
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          // SizedBox(
          //   height: 50,
          //   child: ListTile(
          //   title: Row(
          //     children: const [
          //       Icon(
          //         Icons.share_rounded,
          //         color: Colors.grey,
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Text(
          //         'Share App',
          //         style: TextStyle(
          //           fontSize: 16.0,
          //           fontFamily: 'Calibri Regular',
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ],
          //   ),
          //   onTap: () {
          //      Share.share(AppConstants.share);
          //      Navigator.pop(context);
          //   },
          // ),
          // ),
          
          SizedBox(
            height: 50,
            child: ListTile(
            title: Row(
              children: const [
                Icon(
                  Icons.checklist_sharp,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Privacy Policy',style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Calibri Regular',
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
            onTap: () {
              _launchURL(AppConstants.privacyPolicyUrl);
              Navigator.pop(context);
            },
          ),
          ),
          // SizedBox(
          //   height: 50,
          //   child: ListTile(
          //   title: Row(
          //     children: const [
          //       Icon(
          //         Icons.notifications,
          //         color: Colors.grey,
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       Text('Notifications',style: TextStyle(
          //           fontSize: 16.0,
          //           fontFamily: 'Calibri Regular',
          //           fontWeight: FontWeight.w600,
          //         ),),
          //     ],
          //   ),
          //   onTap: () {
          //     Get.defaultDialog(
          //       title: 'Notifications',
          //       content: const NotificationList(),
          //     );
          //   },
          // ),
          // ),
          SizedBox(
            height: 50,
            child: ListTile(
            title: Row(
              children: const [
                Icon(
                  Icons.people,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('About Us',style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Calibri Regular',
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
            onTap: () {
              _launchURL(AppConstants.aboutUs);
              Navigator.pop(context);
            },
          ),
          ),
        ],
      ),
    );
  }
}

// class NotificationList extends StatefulWidget {
//   const NotificationList({Key? key}) : super(key: key);

//   @override
//   _NotificationListState createState() => _NotificationListState();
// }

// class _NotificationListState extends State<NotificationList> {
//   late Box<String> myNotificationBox;
//   List<String> _checked = [];

//   @override
//   void initState() {
//     super.initState();
//     myNotificationBox = Hive.box<String>(notificationBox);
//     _checked = myNotificationBox.values.toList();
//   }

//   final List<String> tabs = const [
//     'HOT NEWS',
//     'AIRLINES',
//     'DESTINATIONS',
//     'HOTELS',
//     'TOURISM BOARDS',
//     'TOUR OPERATORS',
//     'TRAVEL AGENTS',
//     'MISCELLANEOUS',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ValueListenableBuilder(
//           valueListenable: myNotificationBox.listenable(),
//           builder: (context, Box<String> notifi, _) {
//             return CheckboxGroup(
//               orientation: GroupedButtonsOrientation.VERTICAL,
//               activeColor: AppTheme.kPrimaryColor,
//               margin: const EdgeInsets.only(left: 12.0),
//               onSelected: (List<String> selected) => setState(() {
//                 _checked.clear();
//                 _checked = selected;
//               }),
//               labels: tabs,
//               checked: _checked,
//               onChange: (isChecked, label, index) async {
//                 if (isChecked) {
//                   await FirebaseMessaging.instance
//                       .subscribeToTopic(label.replaceAll(' ', '_'));
//                   await FirebaseMessaging.instance.subscribeToTopic(
//                       label.replaceAll(' ', '_').toLowerCase());
//                   await FirebaseMessaging.instance.subscribeToTopic(
//                       label.replaceAll(' ', '_').capitalizeFirst!);
//                   myNotificationBox.put(index, label);
//                 } else {
//                   await FirebaseMessaging.instance
//                       .unsubscribeFromTopic(label.replaceAll(' ', '_'));
//                   await FirebaseMessaging.instance.unsubscribeFromTopic(
//                       label.replaceAll(' ', '_').toLowerCase());
//                   await FirebaseMessaging.instance.unsubscribeFromTopic(
//                       label.replaceAll(' ', '_').capitalizeFirst!);
//                   myNotificationBox.delete(index);
//                 }
//               },
//               itemBuilder: (Checkbox cb, Text txt, int i) {
//                 return Row(
//                   children: <Widget>[
//                     cb,
//                     txt,
//                   ],
//                 );
//               },
//             );
//           }),
//     );
//   }
// }
