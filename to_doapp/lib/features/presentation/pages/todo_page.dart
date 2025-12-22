import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/state/todo_notifier.dart';
import 'package:to_doapp/features/state/filtered_todo_provider.dart';
// import 'package:to_doapp/features/state/search_query_provider.dart';
import 'package:to_doapp/features/presentation/widgets/search_bar.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: Column(
        children: [
          const TodoSearchBar(),
          Expanded(
            child: todos.isEmpty
                ? const Center(child: Text('No To-Dos found'))
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(
                        title: Text(todo.title),
                        // subtitle: Text(todo.description ?? ''),
                        trailing: Checkbox(
                          value: todo.completed,
                          onChanged: (_) =>
                              ref.read(todoNotifier.notifier).toggleTodo(todo.id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
