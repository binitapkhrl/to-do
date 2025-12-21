import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// Holds current theme mode
final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

// Helper method to get theme data
final lightTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
);
