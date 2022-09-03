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

final streamProvider = StreamProvider((ref) {
  return Stream.periodic(const Duration(milliseconds: 1), (value) {
    return value++;
  });
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(streamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: value.when(
            data: (data) {
              return Text(
                data.toString(),
                style: const TextStyle(fontSize: 24),
              );
            },
            error: (error, trace) => Text(
                  error.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
