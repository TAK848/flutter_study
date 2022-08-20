import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  int counter;
  final String message;
  // コンストラクタでカウンタとメッセージと子Widgetを取る
  MyInheritedWidget(
      {Key? key,
      required this.counter,
      required this.message,
      required Widget child})
      : super(key: key, child: child);

  // O(1)でInheritedWidgetを返却
  // 依存関係を登録し変更時に再構築されるようにする
  static MyInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()
          as MyInheritedWidget;

  //更新されたかどうかの判定ロジック
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) =>
      // oldWidget.counter != counter;
      oldWidget.counter != counter && counter % 2 == 0;
}
