import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget buildLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingAnimationWidget.staggeredDotsWave(
            color: const Color(0xff0d0101), size: 40),
         const SizedBox(
          height: 12,
        ),
         const Text(
          'Loading, Please Wait.....',
          style: TextStyle(color: Color(0xff0d0101), fontSize: 18),
        )
      ],
    ),
  );
}
