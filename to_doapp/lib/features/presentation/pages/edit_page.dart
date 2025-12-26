import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
// import '../../todo/model/todo.dart';
import '../../state/todo_notifier.dart';
import '../../state/todo_by_id_provider.dart';

class EditTodoPage extends ConsumerStatefulWidget {
  final int todoId;

  const EditTodoPage({super.key, required this.todoId});

  @override
  ConsumerState<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends ConsumerState<EditTodoPage> {
  late TextEditingController _titleController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-fill the controller with the current todo title
    final todo = ref.read(todoByIdProvider(widget.todoId));
    if (todo != null && _titleController.text.isEmpty) {
      _titleController.text = todo.title;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final newTitle = _titleController.text.trim();

    // Validate input: task title must not be empty
    if (newTitle.isEmpty) {
      setState(() {
        _errorMessage = 'Task title cannot be empty';
      });
      return;
    }

    // Clear error message on valid input
    setState(() {
      _errorMessage = null;
    });

    // Update the todo via provider
    ref.read(todoNotifier.notifier).updateTodo(widget.todoId, newTitle);

    // Navigate back
    Beamer.of(context).beamBack();
  }

  void _handleCancel() {
    // Navigate back without saving
    Beamer.of(context).beamBack();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final todo = ref.watch(todoByIdProvider(widget.todoId));

    // Handle edge case: if todo is not found
    if (todo == null) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: const Text('Edit Task'),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        body: Center(
          child: Text(
            'Task not found',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title TextField
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                hintText: 'Enter task title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                ),
                errorText: _errorMessage,
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withAlpha(30),
              ),
              maxLines: null,
              onChanged: (_) {
                // Clear error message when user starts typing
                if (_errorMessage != null) {
                  setState(() {
                    _errorMessage = null;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _handleCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: colorScheme.outline),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _handleSave,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
