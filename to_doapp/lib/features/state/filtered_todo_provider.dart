import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/todo_notifier.dart';
import '../todo/model/todo.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final todosAsync = ref.watch(todoNotifier);
  final query = ref.watch(searchQueryProvider);

  return todosAsync.maybeWhen(
    data: (todos) {
      if (query.isEmpty) return todos;
      return todos
          .where((todo) =>
              todo.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    orElse: () => [],
  );
});
