import 'package:flutter/material.dart';
import 'package:hansa_app/extra/custom_double_clip_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomKatalogItemDouble extends StatelessWidget {
  const CustomKatalogItemDouble({
    Key? key,
    required this.imageUrl,
    required this.backgroundColor,
    required this.buttonTextColor,
    required this.buttonColor,
    required this.titleColor,
    required this.stbuttonText,
    required this.ndbuttonText,
    required this.title,
  }) : super(key: key);
  final String imageUrl;
  final Color backgroundColor;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color titleColor;
  final String stbuttonText;
  final String ndbuttonText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Image.asset(
            imageUrl,
            width: 325.w,
            height: 157.h,
          ),
        ),
        CustomDoubleClipItem(
          backgroundColor: backgroundColor,
          buttonTextColor: buttonTextColor,
          buttonColor: buttonColor,
          titleColor: titleColor,
          stbuttonText: stbuttonText,
          ndbuttonText: ndbuttonText,
          title: title,
        ),
      ],
    );
  }
}
