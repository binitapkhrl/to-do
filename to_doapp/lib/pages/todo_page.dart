import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_notifier.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsync = ref.watch(todoNotifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(todoNotifier.notifier).refreshTodos();
            },
          ),
        ],
      ),

body: todoAsync.when(
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (err, _) => Center(child: Text(err.toString())),
  data: (todos) {
    if (todos.isEmpty) {
      return const Center(child: Text('No tasks found. Tap refresh!'));
    }

    return RefreshIndicator(
      // Users can now pull down to refresh!
      onRefresh: () => ref.read(todoNotifier.notifier).refreshTodos(),
      child: ListView.builder(
        // Always good to have physics for shorter lists in RefreshIndicator
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return CheckboxListTile(
            title: Text(todo.title),
            value: todo.completed,
            onChanged: (_) => ref.read(todoNotifier.notifier).toggleTodo(todo.id),
          );
        },
      ),
    );
  },
),
    );
  }
}