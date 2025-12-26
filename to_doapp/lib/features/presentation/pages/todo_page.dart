import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/state/todo_notifier.dart';
import 'package:to_doapp/features/state/user_provider.dart';
import 'package:to_doapp/features/presentation/widgets/search_bar.dart';
import 'package:to_doapp/core/constants/app_strings.dart';
import 'package:to_doapp/features/state/login_provider.dart';
import 'package:to_doapp/features/presentation/widgets/todo_list_widget.dart';
import 'package:to_doapp/features/presentation/widgets/todo_count_widget.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key, required String username});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        title: Consumer(
          builder: (context, ref, _) {
            final username = ref.watch(
              currentUsernameProvider.select((u) => u ?? ''),
            );
            final greeting = AppStrings.greeting(username);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(greeting),
                const SizedBox(width: 8),
                const TodoCountWidget(),
              ],
            );
          },
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) => IconButton(
              icon: Icon(Icons.logout, color: colorScheme.error),
              onPressed: () {
                ref.read(loginProvider.notifier).logout();
                // Optionally navigate to login using Beamer here if desired.
              },
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final todosAsync = ref.watch(todoNotifier);
          return todosAsync.when(
            loading: () => Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            ),
            error: (error, _) => Center(
              child: Text(
                error.toString(),
                style: TextStyle(color: colorScheme.error),
              ),
            ),
            data: (_) => Column(
              children: [
                const TodoSearchBar(),
                Expanded(
                  child: RefreshIndicator(
                    color: colorScheme.primary,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    onRefresh: () async {
                      await ref.read(todoNotifier.notifier).refreshTodos();
                    },
                    child: const TodoListWidget(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
