
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../todo/model/todo.dart';
import '../../state/todo_notifier.dart';

class TodoDetailPage extends ConsumerWidget {
  final int todoId;

  const TodoDetailPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifier);

    return todosAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: const Text('Todo Detail')),
        body: Center(child: Text('Error: $err')),
      ),
      data: (todos) {
        final todo = todos.firstWhere(
          (t) => t.id == todoId,
          orElse: () => Todo(
            id: todoId,
            title: 'Todo Not Found',
            completed: false,
          ),
        );

        return Scaffold(
          appBar: AppBar(title: const Text('Todo Detail')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      todo.completed ? 'Completed' : 'Not Completed',
                      style: TextStyle(
                        color: todo.completed ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600, // Added from second design
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}