import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image? _img;
  Text? _text;

  // ダウンロード処理
  Future<void> _download() async {
    // ファイルのダウンロード
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.ref().child("DL").child("flutter.png");
    String imageUrl = await imageRef.getDownloadURL();
    Reference textRef = storage.ref("DL/hello.txt");
    var data = await textRef.getData();

    // 画面に反映
    setState(() {
      _img = Image.network(imageUrl);
      _text = Text(ascii.decode(data!));
    });

    // ローカルにもファイルを書き込み
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File("${appDocDir.path}/download-logo.png");
    try {
      await imageRef.writeToFile(downloadToFile);
    } catch (e) {
      print(e);
    }
  }

  // アップロード処理
  void _upload() async {
    // imagePickerで画像を選択する
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile == null) {
      return;
    }
    File file = File(pickerFile.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref("UL/upload-pic.png").putFile(file);
      setState(() {
        _text = const Text("UploadDone");
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_img != null) _img!,
              if (_text != null) _text!,
            ],
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
            onPressed: _download,
            child: const Icon(Icons.download_outlined),
          ),
          FloatingActionButton(
            onPressed: _upload,
            child: const Icon(Icons.upload_outlined),
          ),
        ]));
  }
}
