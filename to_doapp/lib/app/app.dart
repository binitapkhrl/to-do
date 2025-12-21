import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Architecture',
      home: const Scaffold(
        body: Center(child: Text('Todo App Skeleton')),
      ),
    );
  }
}
