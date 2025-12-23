import 'package:flutter/material.dart';
import 'package:to_doapp/features/todo/model/todo.dart'; // Adjust path if needed

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;
  final ValueChanged<bool?> onToggle;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional: nicer inner spacing
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            fontSize: 16, // Optional: consistent text size
            color: todo.completed ? Colors.grey : Colors.black87,
          ),
        ),
        trailing: Checkbox(
          value: todo.completed,
          onChanged: onToggle,
          activeColor: Colors.green, // Optional: nicer checkbox color
        ),
        onTap: onTap,
      ),
    );
  }
}