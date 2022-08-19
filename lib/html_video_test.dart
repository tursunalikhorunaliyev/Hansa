import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
       
      ),
    );   
  }
}