// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'app/app.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/todo/ui/counter_page.dart'; // import your notifier file

void main() {
  runApp(
    const ProviderScope(child: MyApp()), // Riverpod needs ProviderScope
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}
