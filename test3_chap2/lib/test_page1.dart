import 'package:flutter/material.dart';
import 'package:test3_chap2/test_page2.dart';

class TestPage1 extends StatelessWidget {
  const TestPage1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Test1",
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const TestPage2();
                },
              ),
            ),
          },
          child: const Text(
            "進む",
            style: TextStyle(
              fontSize: 80,
            ),
          ),
        ),
      ),
    );
  }
}
