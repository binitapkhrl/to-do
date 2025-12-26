import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:to_doapp/core/widgets/todo_list_item.dart';
import 'package:to_doapp/core/constants/app_strings.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/features/state/filtered_todo_provider.dart';
import 'package:to_doapp/features/state/todo_notifier.dart';
import 'package:to_doapp/features/state/user_provider.dart';

/// Shows the filtered todo list and handles item interactions.
class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    // Only the list rebuilds when the filtered list changes.
    final todos = ref.watch(filteredTodoProvider);
    // For navigation path, watch only the username string.
    final username = ref.watch(currentUsernameProvider.select((u) => u ?? ''));

    if (todos.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Center(
            child: Text(
              AppStrings.emptyTodos,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListItem(
          todo: todo,
          onTap: () {
            Beamer.of(
              context,
            ).beamToNamed(Routes.todoDetailPath(username, todo.id));
          },
          onToggle: (_) {
            // Read notifier without subscribing to changes.
            ref.read(todoNotifier.notifier).toggleTodo(todo.id);
          },
        );
      },
    );
  }
}
