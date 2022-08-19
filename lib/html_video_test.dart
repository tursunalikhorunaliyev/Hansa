import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hansa_app/middle_part_widgets/permission_handler_screen.dart';

class HtmlVideoPLayerTest extends StatefulWidget {
  const HtmlVideoPLayerTest({Key? key}) : super(key: key);

  @override
  State<HtmlVideoPLayerTest> createState() => _HtmlVideoPLayerTestState();
}

class _HtmlVideoPLayerTestState extends State<HtmlVideoPLayerTest> {
  String videoTags = '''<video preload="metadata" controls
      loop
      autoplay src="https://hansa-lab.ru/storage/upload/videos/ZnaJMRQsLcXP.mp4"></video>''';
  List<Widget> barchasi = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
      ),
    );   
  }
}