class Routes {
  static const String login = '/';
  static const String todos = '/todos';
  static const todoDetail = '/todos/:username/:id';
  static const editTodo = '/todos/:username/:id/edit';
  
  static String todoDetailPath(String username, int id) => '/todos/$username/$id';
  static String editTodoPath(String username, int id) => '/todos/$username/$id/edit';
}
