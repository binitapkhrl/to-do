
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:to_doapp/features/state/todo_notifier.dart';
import 'package:to_doapp/features/state/filtered_todo_provider.dart';
import 'package:to_doapp/features/presentation/widgets/search_bar.dart';
import 'package:to_doapp/core/widgets/todo_list_item.dart';
import 'package:to_doapp/core/constants/app_strings.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoNotifier);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: todosAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
        data: (_) {
          final todos = ref.watch(filteredTodoProvider);

          return Column(
            children: [
              const TodoSearchBar(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(todoNotifier.notifier).refreshTodos();
                  },
                  child: todos.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(height: 200),
                            Center(
                              child: Text(AppStrings.emptyTodos),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return TodoListItem(
                              todo: todo,
                              onTap: () {
                                Beamer.of(context).beamToNamed('/todos/${todo.id}');
                              },
                              onToggle: (_) {
                                ref
                                    .read(todoNotifier.notifier)
                                    .toggleTodo(todo.id);
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