import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

import '../../../models/b2b_model.dart';
import '../utility/colors.dart';

class HotelDetailsPage extends StatelessWidget {
  const HotelDetailsPage({
    Key? key,
    required this.hotel,
    required this.org,
  }) : super(key: key);
  final Hotel hotel;
  final String org;

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
    String dealType = (hotel.dealType == '0')
        ? 'Public visible to all'
        : 'Private (Visible to $org)';
    String dealInc = (hotel.dealInclusion == '0')
        ? 'CP'
        : (hotel.dealInclusion == '1')
            ? 'MAP'
            : 'AP';
    String dealExp = (hotel.dealExpire == '0')
        ? '1 Day'
        : (hotel.dealExpire == '1')
            ? '1 Week'
            : (hotel.dealExpire == '2')
                ? '2 Months'
                : (hotel.dealExpire == '3')
                    ? '3 Months'
                    : '1 Year';

    return DetailContent(
      headerStyle: headerStyle,
      hotel: hotel,
      footerStyle: footerStyle,
      dealType: dealType,
      org: org,
      dealInc: dealInc,
      dealExp: dealExp,
      linkStyle: linkStyle,
    );
  }
}

class DetailContent extends StatefulWidget {
  const DetailContent({
    Key? key,
    required this.headerStyle,
    required this.hotel,
    required this.footerStyle,
    required this.dealType,
    required this.org,
    required this.dealInc,
    required this.dealExp,
    required this.linkStyle,
  }) : super(key: key);

  final TextStyle headerStyle;
  final Hotel hotel;
  final TextStyle footerStyle;
  final String dealType;
  final String org;
  final String dealInc;
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
      backgroundColor: Style.backgroundcolor,
      persistentFooterButtons: [
        SizedBox(
          width: Get.width - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Person : ${widget.hotel.contactPerson}',
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
                          widget.hotel.contactNumber.split(',');
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text("Call : ${widget.hotel.contactPerson}"),
                            content: SizedBox(
                              height: Get.height * 0.3,
                              child: ListView.builder(
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
                      List<String> mail = widget.hotel.contactPemail.split(',');
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title:
                                Text("Email : ${widget.hotel.contactPerson}"),
                            content: SizedBox(
                              height: Get.height * 0.3,
                              child: ListView.builder(
                                itemCount: mail.length,
                                itemBuilder: (context, index) {
                                  final Uri emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: mail[index],
                                      query:
                                          'subject=Enquiry for deal : ${widget.hotel.dealName}');
                                  return InkWell(
                                    onTap: () {
                                      launch(emailLaunchUri.toString());
                                    },
                                    child: Text(mail[index]),
                                  );
                                },
                              ),
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
        title: Text(widget.hotel.dealName,
            style: const TextStyle(
                color: Style.appbarfontcolor,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
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
                  // final myImage = Image.file(File(imagePath.path));
                  // ImageProvider newImage = myImage.image;
                  // final doc = pw.Document();
                  // doc.addPage(
                  //   pw.Page(
                  //     build: (pw.Context context) {
                  //       return pw.Center(
                  //         child: pw.Container(
                  //           decoration: pw.BoxDecoration(
                  //             image: pw.DecorationImage(image: newI )
                  //           ),
                  //         ),
                  //       ); // Center
                  //     },
                  //   ),
                  // );

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
                    widget.hotel.dealName,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Duration',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.hotel.dealDuration!,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Deal Type',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.dealType,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  (widget.hotel.dealType == '0')
                      ? Text(
                          'Deal price for other B2B',
                          style: widget.headerStyle,
                        )
                      : const SizedBox.shrink(),
                  (widget.hotel.dealType == '0')
                      ? Text(
                          widget.hotel.dealPublicPrice,
                          style: widget.footerStyle,
                        )
                      : const SizedBox.shrink(),
                  const HeightBox(20),
                  Text(
                    'Deal price for (${widget.org})',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.hotel.dealPrivatePrice,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Airport Transfers',
                    style: widget.headerStyle,
                  ),
                  Text(
                    (widget.hotel.dealAirportStatus == '0') ? 'Yes' : 'No',
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Inclusions',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.dealInc,
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Hotel Rating',
                    style: widget.headerStyle,
                  ),
                  SizedBox(
                    width: 150,
                    child: RatingRow(hotel: widget.hotel),
                  ),
                  const HeightBox(20),
                  Text(
                    'Description',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.hotel.dealDescription.replaceAll('BREAKLINE', '\n'),
                    style: widget.footerStyle,
                  ),
                  const HeightBox(20),
                  Text(
                    'Country/State',
                    style: widget.headerStyle,
                  ),
                  Text(
                    widget.hotel.state,
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
                    widget.hotel.contactPerson,
                    style: widget.footerStyle,
                  ),
                  Text(
                    'Email(s):',
                    style: widget.linkStyle,
                  ),
                  SelectableText(
                    widget.hotel.contactPemail,
                    style: widget.footerStyle,
                  ),
                  Text(
                    'Contact Number(s):',
                    style: widget.linkStyle,
                  ),
                  SelectableText(
                    widget.hotel.contactNumber,
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

class RatingRow extends StatelessWidget {
  const RatingRow({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    double value = double.parse(hotel.dealHotelCategory) + 2;
    return Center(
      child: RatingStars(
        value: value,
        onValueChanged: (v) {},
        starBuilder: (index, color) => Icon(
          Icons.star_rounded,
          color: color,
        ),
        starCount: 5,
        starSize: 24,
        maxValue: 5,
        starSpacing: 4,
        maxValueVisibility: true,
        valueLabelVisibility: false,
        animationDuration: const Duration(milliseconds: 1000),
        starOffColor: Colors.black,
        starColor: Colors.orange,
      ),
    );
  }
}
