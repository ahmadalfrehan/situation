import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:situation/exanorated.dart';

void main() {
  runApp(const MyApp());
  //DioHelper.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //base url : https://newsapi.org/
  //method url : v2/top-headlines?
  //querys : country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
  //https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=65f7f556ec76449fa7dc7c0069f040ca
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://universities.hipolabs.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<Response> getData({
    required String pathh,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(pathh,
        queryParameters: query, onReceiveProgress: showDownloadProgress);
  }

  Future downl(Dio dio, String url, String save_path) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(save_path);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  double progress = 0;
  Future<bool> _requestPermission(Permission Pr) async {
    await Pr.request();
    if (Pr.isGranted == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/RPSApp";
          print('new path isssss' + newPath);
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + "/$fileName");
        print('save file sisisisi' + saveFile.path);
        await dio!.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
            progress = value1 / value2;
          });
        });
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  var r;
  void showDownloadProgress(recieved, total) {
    if (total != -1) {
      setState(() {
        r = recieved / total * 100;
      });
      CircularProgressIndicator();
      print((recieved / total * 100).toStringAsFixed(0) + '%');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  var urll = 'http://www.africau.edu/images/default/sample.pdf';
  var dioo = Dio();
  var x;
  var ee;
  bool p = false;
  List<dynamic> w = [];
  //
  Color C = Color(0xFF17BEBB);
  Color C1 = Color(0xFF2E282A);
  var UrlController = TextEditingController();
  // https://api.agify.io?name=meelad
  //http://universities.hipolabs.com/search?country=United+States
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                30,
                10,
                30,
                10,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.lightGreenAccent,
                    ),
                    labelText: " Url "),
                //keyboardAppearance: Brightness.light,
                controller: UrlController,
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'the field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      var tempDir = await getApplicationDocumentsDirectory();
                      String fullPath = tempDir.path + "/boo2";
                      setState(() {
                        x = fullPath;
                      });
                      print('full path ${fullPath}');
                      downl(dioo, UrlController.text, fullPath);
                    },
                    child: const Text('Download'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      OpenFile.open(x);
                    },
                    child: const Text('View'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      p = true;
                      getData(
                        pathh: 'search?',
                        query: {

                        },
                      ).then((value) {

                        w = value.data;
                        print(w.toString());

                      }).catchError(
                        (onError) => print("error happen  + ${onError}"),
                      );
                    },
                    child: const Text('Get Data'),
                  ),
                ),
              ],
            ),
            Center(
                child: Text(!p
                    ? ''
                    : 'please wait while the downloading finish ${r != null ? r.toStringAsFixed(0) : 0} %')),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (w.isEmpty) {
                        var e = const AlertDialog(
                          title: Text('please get the data first !'),
                        );
                        showDialog(context: context, builder: (context) => e);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Exanorated(w),
                          ),
                        );
                      }
                    },
                    child: const Text('Move to see data'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text('Get'),
      ),
    );
  }
}
