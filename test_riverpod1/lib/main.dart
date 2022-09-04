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

final strProvider = Provider.family<String, String>((ref, name) {
  return 'Hello $name';
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(strProvider('Flutter'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
