import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/todo/model/todo.dart';
import 'todo_notifier.dart';

/// Provides a single `Todo` by id, derived from `todoNotifier`.
/// Rebuilds only when the specific item's reference changes.
final todoByIdProvider = Provider.autoDispose.family<Todo?, int>((ref, id) {
  final asyncTodos = ref.watch(todoNotifier);
  return asyncTodos.maybeWhen(
    data: (todos) {
      try {
        return todos.firstWhere((t) => t.id == id);
      } catch (_) {
        return null;
      }
    },
    orElse: () => null,
  );
});
