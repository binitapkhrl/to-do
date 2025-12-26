import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/state/filtered_todo_provider.dart';

class TodoCountWidget extends ConsumerWidget {
  const TodoCountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(
      filteredTodoProvider.select((todos) => todos.length),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.list_alt, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(
          '($count)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
