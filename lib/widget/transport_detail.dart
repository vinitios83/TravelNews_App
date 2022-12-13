import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../models/b2b_model.dart';
import '../utility/colors.dart';

class TransportDetailPage extends StatelessWidget {
  const TransportDetailPage({
    Key? key,
    required this.transport,
  }) : super(key: key);
  final Transport transport;

  @override
  Widget build(BuildContext context) {
    const TextStyle headerStyle = TextStyle(
      color: Colors.blue,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
      height: 1.5,
    );
    const TextStyle footerStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
      height: 2.0,
    );
    const TextStyle linkStyle = TextStyle(
      color: Colors.blue,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.2,
      fontStyle: FontStyle.italic,
      height: 2.0,
    );
    String vechicalType = '';
    String fuelType = '';

    switch (transport.fuelType) {
      case '0':
        fuelType = 'Petrol';
        break;
      case '1':
        fuelType = 'Diesel';
        break;
      case '2':
        fuelType = 'CNG';
        break;
      case '3':
        fuelType = 'Electronic';
        break;
      default:
        fuelType = 'Petrol';
    }

    switch (transport.vechicleCategory) {
      case '0':
        vechicalType = 'Mini (Economical Cars)';
        break;
      case '1':
        vechicalType = 'Prime Sedan (Specious sedans)';
        break;
      case '2':
        vechicalType = 'Prime Play (Music,Tv)';
        break;
      case '3':
        vechicalType = 'Compact SUV';
        break;
      case '4':
        vechicalType = 'Specious SUV';
        break;
      default:
        vechicalType = 'Mini (Economical Cars)';
    }

    String dealExp = (transport.dealExpire == '0')
        ? '1 Day'
        : (transport.dealExpire == '1')
            ? '1 Week'
            : (transport.dealExpire == '2')
                ? '2 Months'
                : (transport.dealExpire == '3')
                    ? '3 Months'
                    : '1 Year';

    return DetailContent(
      headerStyle: headerStyle,
      transport: transport,
      footerStyle: footerStyle,
      fuelType: fuelType,
      vechicalType: vechicalType,
      dealExp: dealExp,
      linkStyle: linkStyle,
    );
  }
}

class DetailContent extends StatefulWidget {
  const DetailContent({
    Key? key,
    required this.headerStyle,
    required this.transport,
    required this.footerStyle,
    required this.fuelType,
    required this.vechicalType,
    required this.dealExp,
    required this.linkStyle,
  }) : super(key: key);

  final TextStyle headerStyle;
  final Transport transport;
  final TextStyle footerStyle;
  final String fuelType;

  final String vechicalType;
  final String dealExp;
  final TextStyle linkStyle;

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  // late Uint8List _imageFile;

  late ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        SizedBox(
          width: Get.width - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Person : ${widget.transport.contactPerson}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      List<String> number =
                          widget.transport.contactNumber.split(',');
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text(
                                "Call : ${widget.transport.contactPerson}"),
                            content: ListView.builder(
                              itemCount: number.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber(
                                        number[index]);
                                  },
                                  child: Text(number[index]),
                                );
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      width: Get.width * 0.5 - 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.phone),
                          Text('Call'),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      List<String> mail =
                          widget.transport.contactPemail.split(',');
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text(
                                "Email : ${widget.transport.contactPerson}"),
                            content: ListView.builder(
                              itemCount: mail.length,
                              itemBuilder: (context, index) {
                                final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: mail[index],
                                    query:
                                        'subject=Enquiry for deal : ${widget.transport.dealName}');
                                return InkWell(
                                  onTap: () {
                                    launch(emailLaunchUri.toString());
                                  },
                                  child: Text(mail[index]),
                                );
                              },
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      width: Get.width * 0.5 - 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(CupertinoIcons.mail),
                          Text('Email'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      appBar: AppBar(
        backgroundColor: Style.appbarcolor,
        title: Text(
          widget.transport.dealName,
          style: const TextStyle(
              color: Style.appbarfontcolor,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await screenshotController
                  .capture(delay: const Duration(milliseconds: 10))
                  .then((Uint8List? image) async {
                if (image != null) {
                  final directory = await getApplicationDocumentsDirectory();
                  final imagePath = await File(
                          '${directory.path}/${DateTime.now().toIso8601String()}.png')
                      .create();
                  await imagePath.writeAsBytes(image);

                  /// Share Plugin
                  await Share.shareFiles([imagePath.path]);
                }
              });
            },
            child: const Icon(Icons.print_rounded),
          ),
          const WidthBox(20),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                // color: AppTheme.kMarqueeColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deal Name',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.dealName,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Vechial Type',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.vechicalType,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Fuel Type',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.fuelType,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Daily Rent',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.dailyRent,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Cost per km',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.costPerKm,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Cost per hour',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.costPerHour,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Cost per extra hour',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.costPerExtraHour,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Description',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.dealDescription
                        .replaceAll('BREAKLINE', ' '),
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Country/State',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.transport.state,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Expire after',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.dealExp,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(30),
                  const Divider(
                    color: Colors.black,
                  ),
                  const HeightBox(20),
                  Text(
                    'Deal By:',
                    style: widget.linkStyle,
                  ),
                  SelectableText(
                    widget.transport.contactPerson,
                    style: widget.footerStyle,
                  ),
                  Text(
                    'Email(s):',
                    style: widget.linkStyle,
                  ),
                  SelectableText(
                    widget.transport.contactPemail,
                    style: widget.footerStyle,
                  ),
                  Text(
                    'Contact Number(s):',
                    style: widget.linkStyle,
                  ),
                  SelectableText(
                    widget.transport.contactNumber,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  const Divider(
                    color: Colors.black,
                  ),
                  const HeightBox(20),
                  Center(
                    child: Text(
                      'Powered by Travel World Online',
                      style: widget.linkStyle.copyWith(
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
