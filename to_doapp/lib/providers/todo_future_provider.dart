import 'package:flutter_riverpod/flutter_riverpod.dart ';
import '../features/todo/data/todo_service.dart';
import '../features/todo/model/todo.dart';
final todoServiceProvider = Provider((ref) => TodoService());
final todoFutureProvider =
    FutureProvider<List<Todo>>((ref) async {
  return ref.read(todoServiceProvider).fetchTodos();
});
