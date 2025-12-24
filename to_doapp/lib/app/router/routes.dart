class Routes {
  static const String login = '/';
  static const String todos = '/todos';
   static const todoDetail = '/todos/:username/:id';
   static String todoDetailPath(String username, int id) => '/todos/$username/$id';
}
