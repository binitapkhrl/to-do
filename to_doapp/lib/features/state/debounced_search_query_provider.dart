import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_query_provider.dart'; // your StateProvider<String>

class DebouncedSearchNotifier extends StateNotifier<String> {
  Timer? _timer;

  DebouncedSearchNotifier(Ref ref) : super('') {
    // Listen to the immediate search query
    ref.listen<String>(searchQueryProvider, (previous, next) {
      _timer?.cancel();

      _timer = Timer(const Duration(milliseconds: 500), () {
        state = next.trim();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// The provider
final debouncedSearchQueryProvider =
    StateNotifierProvider<DebouncedSearchNotifier, String>((ref) {
  return DebouncedSearchNotifier(ref);
});