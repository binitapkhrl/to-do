import 'package:flutter_riverpod/flutter_riverpod.dart';

// Counter StateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0); // initial value 0

  void increment() => state++;
  void decrement() => state--;
}

// Riverpod provider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
