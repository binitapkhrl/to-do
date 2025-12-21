import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/todo/model/task.dart';
import 'package:uuid/uuid.dart';

// Task list state notifier
class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  final _uuid = Uuid();

  void addTask(String title) {
    state = [...state, Task(id: _uuid.v4(), title: title)];
  }

  void toggleTask(String id) {
    state = state
        .map((task) =>
            task.id == id ? task.copyWith(completed: !task.completed) : task)
        .toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

// Provider
final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});
