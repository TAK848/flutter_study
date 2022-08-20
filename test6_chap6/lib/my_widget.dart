import 'package:flutter/material.dart';

import 'my_inherited_widget.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyInheritedWidget myInheritedWidget = MyInheritedWidget.of(context);
    String message =
        "${myInheritedWidget.message}\nCount is ${myInheritedWidget.counter} ";
    return Text(message, style: Theme.of(context).textTheme.headline4);
  }
}
