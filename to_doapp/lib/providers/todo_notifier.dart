import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/todo/data/todo_service.dart';
import '../features/todo/model/todo.dart';

// Service provider (moved here after removing todo_future_provider.dart)
final todoServiceProvider = Provider.autoDispose((ref) => TodoService());
final todoNotifier = AutoDisposeAsyncNotifierProvider<TodoNotifier, List<Todo>>(TodoNotifier.new);

class TodoNotifier extends AutoDisposeAsyncNotifier<List<Todo>> {
  @override
  FutureOr<List<Todo>> build() async {
    final service = ref.read(todoServiceProvider);
    return service.fetchTodos();
  }

  Future<void> refreshTodos() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(todoServiceProvider);
      return service.fetchTodos();
    });
  }

  Future<void> toggleTodo(int id) async {
    final current = state.value ?? await future;
    state = AsyncData(current
        .map((todo) => todo.id == id
            ? Todo(id: todo.id, title: todo.title, completed: !todo.completed)
            : todo)
        .toList());
  }
}