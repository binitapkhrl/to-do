import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../todo/model/todo.dart';
import '../../state/todo_notifier.dart';
import 'package:to_doapp/core/constants/app_strings.dart';

class TodoDetailPage extends ConsumerWidget {
  final int todoId;

  const TodoDetailPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifier);
    // Access the theme color scheme
    final colorScheme = Theme.of(context).colorScheme;

    return todosAsync.when(
      loading: () => Scaffold(
        backgroundColor: colorScheme.surface, // Matches Login background
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, _) => Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: const Text(AppStrings.todoDetailTitle),
          backgroundColor: colorScheme.surface,
        ),
        body: Center(child: Text('Error: $err', style: TextStyle(color: colorScheme.error))),
      ),
      data: (todos) {
        final todo = todos.firstWhere(
          (t) => t.id == todoId,
          orElse: () => Todo(
            id: todoId,
            title: AppStrings.emptyTodos, 
            completed: false,
          ),
        );

        return Scaffold(
          backgroundColor: colorScheme.surface, // Using Theme Surface
          appBar: AppBar(
            title: const Text(AppStrings.todoDetailTitle),
            centerTitle: true,
            elevation: 0,
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 0, // Material 3 uses subtle tonal elevation
              color: colorScheme.surfaceVariant.withOpacity(0.3), // Tonal theme color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: colorScheme.outlineVariant), // Subtle border
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Wrap content
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon matching Login page style
                    Icon(
                      todo.completed ? Icons.check_circle_outline : Icons.pending_outlined,
                      color: todo.completed ? Colors.green : colorScheme.primary,
                      size: 40,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: todo.completed 
                            ? Colors.green.withOpacity(0.1) 
                            : colorScheme.errorContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        todo.completed ? AppStrings.completion : AppStrings.notCompletion,
                        style: TextStyle(
                          color: todo.completed ? Colors.green : colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
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