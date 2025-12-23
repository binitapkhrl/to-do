import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:to_doapp/features/state/todo_notifier.dart';
import 'package:to_doapp/features/state/filtered_todo_provider.dart';
import 'package:to_doapp/features/presentation/widgets/search_bar.dart';
import 'package:to_doapp/core/widgets/todo_list_item.dart';
import 'package:to_doapp/core/constants/app_strings.dart';
import 'package:to_doapp/features/state/login_provider.dart'; // Import to handle logout

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      // Use the theme's surface color for the background
      backgroundColor: colorScheme.surface,
      
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        actions: [
          // Added Logout Button
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.error),
            onPressed: () {
              ref.read(loginProvider.notifier).logout();
              Beamer.of(context).beamToReplacementNamed('/');
            },
          ),
        ],
      ),

      body: todosAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: colorScheme.primary),
        ),
        error: (error, _) => Center(
          child: Text(
            error.toString(),
            style: TextStyle(color: colorScheme.error),
          ),
        ),
        data: (_) {
          final todos = ref.watch(filteredTodoProvider);

          return Column(
            children: [
              // The SearchBar will now sit on the theme surface
              const TodoSearchBar(),
              
              Expanded(
                child: RefreshIndicator(
                  color: colorScheme.primary,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  onRefresh: () async {
                    await ref.read(todoNotifier.notifier).refreshTodos();
                  },
                  child: todos.isEmpty
                      ? ListView(
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
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return TodoListItem(
                              todo: todo,
                              onTap: () {
                                Beamer.of(context).beamToNamed('/todos/${todo.id}');
                              },
                              onToggle: (_) {
                                ref.read(todoNotifier.notifier).toggleTodo(todo.id);
                              },
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}