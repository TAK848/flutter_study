import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

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
  Text? _text;
  Image? _image;

  // OCRを行う
  Future<void> _ocr() async {
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickerFile == null) {
      return;
    }
    final InputImage imageFile = InputImage.fromFilePath(pickerFile.path);
    final textRecognizer =
        TextRecognizer(script: TextRecognitionScript.japanese);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(imageFile);
    String text = recognizedText.text;
    /*
    for (TextBlock block in recognizedText.blocks) {
      // ブロック単位で取得したい情報がある場合はここに記載
      for (TextLine line in block.lines) {
        // ライン単位で取得したい情報がある場合はここに記載
      }
    }
    */

    // 画面に反映
    setState(() {
      _text = Text(text);
      _image = Image.file(File(pickerFile.path));
    });

    // リソースの開放
    textRecognizer.close();
  }

  // ラベリングを行う
  Future<void> _labeling() async {
    final pickerFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickerFile == null) {
      return;
    }
    final InputImage imageFile = InputImage.fromFilePath(pickerFile.path);
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.7);
    final imageLabeler = ImageLabeler(options: options);
    final List<ImageLabel> labels = await imageLabeler.processImage(imageFile);

    String text = "";
    for (ImageLabel label in labels) {
      text +=
          "${label.label} (${(label.confidence * 100).toStringAsFixed(0)}%)\n";
    }

    // 画面に反映
    setState(() {
      _text = Text(text);
      _image = Image.file(File(pickerFile.path));
    });

    // リソースの開放
    imageLabeler.close();
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
              if (_text != null) _text!,
              if (_image != null) SafeArea(child: _image!),
            ],
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          FloatingActionButton(
              onPressed: _ocr, child: const Icon(Icons.photo_album)),
          FloatingActionButton(
              onPressed: _labeling, child: const Icon(Icons.photo_camera))
        ]));
  }
}
