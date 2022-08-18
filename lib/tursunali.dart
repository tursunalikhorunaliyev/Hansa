import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Tursunali extends StatefulWidget {
  const Tursunali({Key? key}) : super(key: key);

  @override
  State<Tursunali> createState() => _TursunaliState();
}

class _TursunaliState extends State<Tursunali> {

  List<String> videoLinks = ["https://hansa-lab.ru/storage/upload/videos/ZnaJMRQsLcXP.mp4","https://hansa-lab.ru/storage/upload/videos/1d-otmvmwUva.mp4","https://hansa-lab.ru/storage/upload/videos/o6Qt8FWns68q.mp4","https://hansa-lab.ru/storage/upload/videos/aNLeAmhM70NY.mp4"];
  String videoLink = "https://hansa-lab.ru/storage/upload/videos/ZnaJMRQsLcXP.mp4";
  int index = 0;
  @override
  Widget build(BuildContext context) {
    videoLink = videoLinks[index];
     ChewieController chewieController = ChewieController(
       aspectRatio: 16/9,
       autoPlay: true,
       videoPlayerController: VideoPlayerController.network(videoLink));
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 250,
              child: Chewie(
                controller: chewieController,
              
                ),
            ),
              SizedBox(height: 80,),
            MaterialButton(onPressed: (){
              chewieController.pause();
              chewieController.videoPlayerController.pause();
              
               index++;
               setState(() {
                 
               });
            },
            
            color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}