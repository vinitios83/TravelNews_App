import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/ads_controller.dart';
import '../utility/constant.dart';

class MyBannerAds extends StatefulWidget {
  const MyBannerAds({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBannerAds> createState() => _MyBannerAdsState();
}

class _MyBannerAdsState extends State<MyBannerAds> {
  AdsController adsController = Get.put(AdsController());
  void _launchURL(url) async => await launchUrl(url)
      ? await launchUrl(url)
      : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (adsController.isLoading.isTrue) {
        return const SizedBox.shrink();
      } else {
        return Container(
          height: 50.0,
          color: Colors.black,
          child: CarouselSlider.builder(
            itemCount: adsController.bannerAds.length,
            autoSliderTransitionTime: const Duration(microseconds: 2),
            slideTransform: const FlipVerticalTransform(),
            enableAutoSlider: true,
            autoSliderDelay: Duration(seconds: adsController.refreshRate.value),
            unlimitedMode: true,
            slideBuilder: (index) {
              var item = adsController.bannerAds.elementAt(index);
              String img = AppConstants.adsBaseUrl + item.imageurl;
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      _launchURL(item.hiturl);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      }
    });
  }
}
