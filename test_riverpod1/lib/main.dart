import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RiverpodSample(),
    );
  }
}

final stateProvider = StateProvider((ref) {
  return 0;
});

class RiverpodSample extends StatelessWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(stateProvider);
            final countController = ref.watch(stateProvider.notifier);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  count.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    countController.state *= 2;
                  },
                  child: const Text('Increment'),
                ),
                child ?? Container()
              ],
            );
          },
          child: const Text('Counter'),
        ),
      ),
    );
  }
}
