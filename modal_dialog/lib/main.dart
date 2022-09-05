import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final countStateProvider = StateProvider((ref) {
  return 0;
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AlertSample(),
    );
  }
}

class AlertSample extends ConsumerWidget {
  const AlertSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countStateProvider);
    final countStateController = ref.read(countStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alert Sample"),
      ),
      body: Center(
        child: Text("Count: $count"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const MyCupertinoDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyCupertinoDialog extends ConsumerWidget {
  const MyCupertinoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countStateController = ref.read(countStateProvider.notifier);
    return CupertinoAlertDialog(
      title: const Text("Alert"),
      content: const Text("This is an alert."),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            countStateController.state++;
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
