import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import '../../todo/model/todo.dart';
import '../../state/todo_notifier.dart';
import '../../state/todo_by_id_provider.dart';
import '../../state/user_provider.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/core/constants/app_strings.dart';

class TodoDetailPage extends ConsumerWidget {
  final int todoId;

  const TodoDetailPage({super.key, required this.todoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only granular parts of the async state to minimize rebuilds
    final isLoading = ref.watch(
      todoNotifier.select((async) => async.isLoading),
    );
    final errorObj = ref.watch(
      todoNotifier.select(
        (async) => async.hasError ? async.asError?.error : null,
      ),
    );
    // Watch only the specific todo by id
    final todo = ref.watch(todoByIdProvider(todoId));
    // Watch the current username from the provider
    final username = ref.watch(currentUsernameProvider) ?? 'Guest';

    // Access the theme color scheme
    final colorScheme = Theme.of(context).colorScheme;
    if (isLoading) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorObj != null) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: const Text(AppStrings.todoDetailTitle),
          backgroundColor: colorScheme.surface,
        ),
        body: Center(
          child: Text(
            'Error: $errorObj',
            style: TextStyle(color: colorScheme.error),
          ),
        ),
      );
    }

    final resolved =
        todo ??
        Todo(id: todoId, title: AppStrings.emptyTodos, completed: false);

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
              color: colorScheme.surfaceContainerHighest.withAlpha(30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      resolved.completed
                          ? Icons.check_circle_outline
                          : Icons.pending_outlined,
                      color: resolved.completed
                          ? colorScheme.primary
                          : colorScheme.error,
                      size: 40,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      resolved.title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: resolved.completed
                            ? colorScheme.primary.withAlpha(35)
                            : colorScheme.errorContainer.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        resolved.completed
                            ? AppStrings.completion
                            : AppStrings.notCompletion,
                        style: TextStyle(
                          color: resolved.completed
                              ? colorScheme.primary
                              : colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Beamer.of(context).beamToNamed(
                                Routes.editTodoPath(username, resolved.id),
                              );
                            },
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Edit'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.tonalIcon(
                            onPressed: () {
                              ref
                                  .read(todoNotifier.notifier)
                                  .deleteTodo(resolved.id);
                              Beamer.of(context).beamBack();
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
  }
}
