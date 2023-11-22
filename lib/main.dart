import 'dart:io';

import 'package:chunked_uploader/chunked_uploader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<ScaffoldState> _scafoldState = GlobalKey<ScaffoldState>();
  late BuildContext bcontext;
  late File file;
  double vprogress  = 0;

  Future getfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      // User canceled the picker
    }

  }

  /**      ****** MAKE SURE TO ADD YOUR LINK HERE  ******       **/

  Future<void> _uploadFile(filepath) async {
    String fileName = basename(filepath.path);
    print("file base name : $fileName");

    final dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.7/upload/images.php',
      headers: {'Authorization': 'Bearer'},
    ));

    final uploader = ChunkedUploader(dio);

    try{
      final response = await uploader.uploadUsingFilePath(
        fileName: fileName,
        filePath: file.path!,
        maxChunkSize: 1024*1024*25,
        path: '/file',
        onUploadProgress: (progress){print(progress);setState(() {
          vprogress = progress;
        });},
      );



    }catch(e){
      _showSnackBar(e);
    }
  }


  /**     ***********        **/

  @override
  Widget build(BuildContext context) {
    bcontext = context;
    return MaterialApp(

    home:
      Scaffold(
      appBar: AppBar(
        title: const Text("upload file"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async{
                 file = await getfile();
              },
              child: const Text('Select File'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                try{
                    setState(() {
                      vprogress =0;
                    });
                    _uploadFile(file);
                }catch(e){

                }
              },
              child: const Text('Upload'),
            ),

            LinearProgressIndicator(
              value: vprogress,
              color:Colors.green,
              minHeight: 20,


            )
          ],
        ),
      ),
    ));
  }

  void _showSnackBar(data) {

    ScaffoldMessenger.of(bcontext).showSnackBar(SnackBar(content: Text(data)));
  }
}


