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

final dateProvider = Provider((ref) {
  return DateTime.now();
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.toString(),
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                ref.refresh(dateProvider);
              },
              child: const Text(
                "Refresh",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
