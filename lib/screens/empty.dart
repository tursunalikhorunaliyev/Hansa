/* import 'package:flutter/material.dart';
import 'package:video_viewer/video_viewer.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  final videoViewerController = VideoViewerController();
  @override
  void initState() {
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          VideoViewer(
            source: {
              "Video": VideoSource(
                video: VideoPlayerController.network("https://youtu.be/oViZ3tokCZc")
              ),
            },
            controller: videoViewerController,
          ),
          MaterialButton(onPressed: (){
            videoViewerController.play();
          }, color: Colors.amber,)
        ],
      )
    );
  }
}
 */