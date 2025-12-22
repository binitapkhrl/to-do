import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/todo_future_provider.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsync = ref.watch(todoFutureProvider);

    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: todoAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(todos[index].title),
              value: todos[index].completed,
              onChanged: null, // read-only for now
            );
          },
        ),
      ),
    );
  }
}
