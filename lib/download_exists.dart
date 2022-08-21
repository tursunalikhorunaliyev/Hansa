import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hansa_app/blocs/download_progress_bloc.dart';
import 'package:path_provider/path_provider.dart';

class ExistsCheck extends StatefulWidget {
  const ExistsCheck({Key? key}) : super(key: key);

  @override
  State<ExistsCheck> createState() => _ExistsCheckState();
}

class DownLoad {
  final controller = StreamController<double>();
  Stream<double> get stream => controller.stream;
  StreamSink<double> get sink => controller.sink;
}

class _ExistsCheckState extends State<ExistsCheck> {
  final bloc = DownLoad();
  Future<Map<String, dynamic>> getFilePath(uniqueFileName) async {
    Map<String, dynamic> temp = {};
    String path = "";
    String dir = "";
    if (Platform.isIOS) {
      Directory directory = await getApplicationSupportDirectory();
      dir = directory.path;
    } else if (Platform.isAndroid) {
      dir = "/storage/emulated/0/Download/";
    }
    path = "$dir/$uniqueFileName.mp4";
    final fileExist = File(path);

    if (await fileExist.exists()) {
    
      temp = {"uri": path, "isExist": true};
    } else {
      
      temp = {"uri": path, "isExist": false};
    }
    return temp;
  }

  Future<String> downloadFile(String url, String fileName,
      DownLoad downloadProgressFileBloc) async {
    double progress = 0;
    Map<String, dynamic> savePath = await getFilePath(fileName);
    if (!savePath["isExist"]) {
      Dio dio = Dio();
      dio.download(
        url,
        savePath,
        onReceiveProgress: (recieved, total) {
          print(((recieved / total) * 100).toStringAsFixed(0));

          progress =
              double.parse(((recieved / total) * 100).toStringAsFixed(0));
          downloadProgressFileBloc.sink.add(progress);
        },
        deleteOnError: true,
      );
      return "can download";
    } else {
      return "can't download";
    }
  }

   
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
    
          StreamBuilder<double>(
            stream: bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(height: 50,),
          TextButton(onPressed: (){
            downloadFile("https://hansa-lab.ru/storage/upload/videos/ZnaJMRQsLcXP.mp4", "video", bloc).then((value) {
              log(value);
            });
          }, child: const Text("Download"))
        ],
      ),
    );
  }
}
