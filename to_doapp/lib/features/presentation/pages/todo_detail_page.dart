import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
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
        backgroundColor: colorScheme.surface, 
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
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: const Text(AppStrings.todoDetailTitle),
            centerTitle: true,
            elevation: 0,
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 0, // Material 3 uses subtle tonal elevation
                  color: colorScheme.surfaceContainerHighest.withAlpha(30), // Tonal theme color
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
                          color: todo.completed ? colorScheme.primary : colorScheme.error,
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
                                ? colorScheme.primary.withAlpha(35)
                                : colorScheme.errorContainer.withAlpha(30),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            todo.completed ? AppStrings.completion : AppStrings.notCompletion,
                            style: TextStyle(
                              color: todo.completed ? colorScheme.primary : colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.edit_outlined),
                                label: const Text('Edit'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: FilledButton.tonalIcon(
                                onPressed: () {
                                  ref.read(todoNotifier.notifier).deleteTodo(todo.id);
                                  Beamer.of(context).beamBack(); // Better than pop for Beamer
                                },
                                icon: const Icon(Icons.delete_outline),
                                label: const Text('Delete'),
                                style: FilledButton.styleFrom(
                                  foregroundColor: colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}