import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen>
    with SingleTickerProviderStateMixin {
  bool downloading = false;
  String progress = "0";
  bool isDownloaded = false;
  String uri =
      "http://research.nhm.org/pdfs/10840/10840-001.pdf";
  String fileName = "test.pdf";
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
        print(((recieved/total)*100).toStringAsFixed(0));
        setState(() {
          progress = ((recieved/total)*100).toStringAsFixed(0);
        });
        if(progress=="100"){

          setState(() {
            isDownloaded = true;
          });
        }
        else if(double.parse(progress)<100){

        }
      },
      deleteOnError: true,

    ).then((value) {
      setState(() {
        if(progress == "100"){
          isDownloaded = true;
        }
        downloading = false;
      });
    });
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = "";
    Directory dir = await getApplicationDocumentsDirectory();
    path = "${dir.path}/$uniqueFileName.pdf";
    return path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Text("$progress%"),
       
          isDownloaded?const Text("Downloaded"):const Text("Click start button to download file"),
          MaterialButton(onPressed: ()async{
            downloadFile();
          }, child: const Text("Start"),)
        ],
      ),
    ));
  }
}
