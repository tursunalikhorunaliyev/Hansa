import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen>
    with SingleTickerProviderStateMixin {
  bool downloading = false;
  double progress = 0;
  bool isDownloaded = false;
  String uri = "https://hansa-lab.ru/storage/upload/videos/SPuO_h3vtouX.mp4";
  String fileName = "video.mp4";
  Future<void> downloadFile() async {
    setState(() {
      downloading = true;
    });
    String savePath = await getFilePath(fileName);
    Dio dio = Dio();
    dio.download(
      uri,
      savePath,
      onReceiveProgress: (recieved, total) {
        print(((recieved / total) * 100).toStringAsFixed(0));
        setState(() {
          progress =
              double.parse(((recieved / total) * 100).toStringAsFixed(0));
        });
        if (progress == 100) {
          setState(() {
            isDownloaded = true;
          });
        } else if (progress < 100) {}
      },
      deleteOnError: true,
    ).then((value) {
      setState(() {
        if (progress == 100) {
          isDownloaded = true;
        }
        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = "";
    String dir = "/storage/emulated/0/Download/";
    path = "$dir/$uniqueFileName.mp4";
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: AlertDialog(
                content: Padding(
                  padding: const EdgeInsets.only(top: 5 ,),
                  child: LinearPercentIndicator(
                    barRadius: Radius.circular(5),
                 
                  lineHeight: 15,
                  
                  percent: progress/100,
                  center: Text("$progress%" , style: GoogleFonts.montserrat(
                    color: Colors.black,

                  ),),
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.green,
                  ),
                ),
                actions: [

                  MaterialButton(
                    
                    onPressed: (){
                    Navigator.of(context).pop();
                  } , child: Text("Cancel" , style: GoogleFonts.montserrat(
                    color: Colors.black , fontSize: 12 , 
                  ),)),
                  MaterialButton(
                    
                    onPressed: (){
                    downloadFile();
                  } , child: Text("Download" , style: GoogleFonts.montserrat(
                    color: Colors.black , fontSize: 12 , 
                  ),)),
                ],
              )
            ),
        ));
  }
}
