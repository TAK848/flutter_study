import 'package:flutter/material.dart';

class TestPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Test1"),
        ),
        body: Center(
            child: Container(
                color: Colors.redAccent,
                child: const Text("Test1", style: TextStyle(fontSize: 80)))));
  }
}
