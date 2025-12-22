import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/state/search_query_provider.dart';

class TodoSearchBar extends ConsumerWidget {
  const TodoSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search To-Dos...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
        controller: TextEditingController(text: searchQuery),
      ),
    );
  }
}
