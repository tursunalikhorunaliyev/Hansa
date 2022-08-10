import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hansa_app/extra/custom_bottom_tablet_item.dart';
import 'package:hansa_app/extra/custom_double_clip_item.dart';

class TabletKatalogItem extends StatelessWidget {
  const TabletKatalogItem(
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
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Image.network(
            imageUrl,
            width: 200.w,
            height: 150.h,
            fit: BoxFit.cover,
          ),
        ),
        TabletKatalogBottomItem(
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
    );
  }
}
