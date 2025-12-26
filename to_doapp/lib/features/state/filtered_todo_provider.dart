import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/todo/model/todo.dart';
import 'todo_notifier.dart';
// import 'search_query_provider.dart';
import 'package:to_doapp/features/state/debounced_search_query_provider.dart';

final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final todoAsync = ref.watch(todoNotifier);
  // final query = ref.watch(searchQueryProvider).toLowerCase();
  final query = ref.watch(debouncedSearchQueryProvider).toLowerCase();

  return todoAsync.when(
    data: (todos) {
      if (query.isEmpty) return todos;

      return todos
          .where(
            (todo) => todo.title.toLowerCase().contains(query),
          )
          .toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
