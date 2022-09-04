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

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'First Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NextPage()));
                },
                child: const Text(
                  'Transition to the next page',
                  style: TextStyle(fontSize: 24),
                )),
          ],
        ),
      ),
    );
  }
}

final futureProvider = FutureProvider.autoDispose((ref) async {
  return await Future.delayed(const Duration(seconds: 3), () {
    ref.maintainState = true;
    return 'Hello Future Riverpod';
  });
});

class NextPage extends ConsumerWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureProvider);

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
