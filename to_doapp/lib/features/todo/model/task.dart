class Task {
  final String id;
  final String title;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    this.completed = false,
  });

  // copyWith to update task
  //?? is generally used with copy with so that we can keep the new value if one exists or use the previous one
  //? is used to make the parameters optional, string? means it can be null or a string
  Task copyWith({String? id, String? title, bool? completed}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}
