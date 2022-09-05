import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

void main() {
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final imagePicker = ImagePicker();
  XFile? _image;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future getImageFromGarally() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,

      // allowedExtensions: ['jpg', 'png'],
    );
    // check whether pickedFile is jpeg or jpg or png or heic. if not ,raise error
    if (pickedFile == null) {
      return;
    }
    print(p.extension(pickedFile.path));
    const ok = ['.jpg', '.jpeg', '.png', '.heic'];
    if (!ok.contains(p.extension(pickedFile.path).toLowerCase())) {
      throw Exception('not a valid image');
    } else {
      print('ok!');
    }
    setState(() {
      _image = pickedFile;
    });

    final snackBar = SnackBar(
      content: const Text('ボタンを押しました！'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      _image = XFile(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                '項目',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1),
                  ),
                  hintText: 'aaa',
                  contentPadding: const EdgeInsets.all(12.5),
                ),
              ),
              TextButton(
                onPressed: () {
                  print('aaa');
                  getImageFromGarally();
                },
                child: Text('画像を選ぶ'),
              ),
              if (_image != null)
                Stack(
                  children: [
                    Image.file(
                      File(_image!.path),
                      width: 100,
                      height: 100,
                    ),
                    Positioned(
                      right: -10,
                      top: -10,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _image = null;
                          });
                        },
                        icon: const Material(
                          shape: CircleBorder(side: BorderSide(width: 1)),
                          // color: Colors.transparent,
                          child: Icon(
                            Icons.close,
                            // color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
