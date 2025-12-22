import 'package:flutter/material.dart';
import '../pages/todo_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo Architecture',
      home: const TodoPage(),
    );
  }
}
