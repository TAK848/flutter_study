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

class User {
  User(this.name, this.age);
  final String name;
  final int age;
}

class UserStateNotifier extends StateNotifier<User> {
  UserStateNotifier() : super(User("", 20));

  void setName(String newName) => state = User(newName, state.age);
  void setAge(int newAge) => state = User(state.name, newAge);

  get age => state.age;
  get name => state.name;
}

final stateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, User>((ref) {
  return UserStateNotifier();
});

class RiverpodSample extends ConsumerWidget {
  const RiverpodSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStateController = ref.read(stateNotifierProvider.notifier);
    final user = ref.watch(stateNotifierProvider.select((value) => value.name));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Sample'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Age",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    userStateController.age.toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    user,
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  hintText: '名前を入力してください',
                ),
                onChanged: (text) {
                  userStateController.setName(text);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userStateController.setAge(userStateController.age + 1);
        },
        tooltip: 'Increment Age',
        child: const Icon(Icons.add),
      ),
    );
  }
}
