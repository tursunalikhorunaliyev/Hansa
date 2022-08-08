import 'package:flutter/material.dart';
import 'package:hansa_app/extra/custom_double_clip_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomKatalogItemDouble extends StatelessWidget {
  const CustomKatalogItemDouble(
      {Key? key,
      required this.imageUrl,
      required this.backgroundColor,
      required this.buttonTextColor,
      required this.buttonColor,
      required this.titleColor,
      required this.stbuttonText,
      required this.ndbuttonText,
      required this.title,
      required this.linkPDF,
      required this.linkPDFSkachat})
      : super(key: key);
  final String imageUrl;
  final Color backgroundColor;
  final Color buttonTextColor;
  final Color buttonColor;
  final Color titleColor;
  final String stbuttonText;
  final String ndbuttonText;
  final String title;
  final String linkPDF;
  final String linkPDFSkachat;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 157.h,
              fit: BoxFit.cover,
            ),
          ),
          CustomDoubleClipItem(
            linkPDFSkachat: linkPDFSkachat,
            linkPDF: linkPDF,
            backgroundColor: backgroundColor,
            buttonTextColor: buttonTextColor,
            buttonColor: buttonColor,
            titleColor: titleColor,
            stbuttonText: stbuttonText,
            ndbuttonText: ndbuttonText,
            title: title,
          ),
        ],
      ),
    );
  }
}
