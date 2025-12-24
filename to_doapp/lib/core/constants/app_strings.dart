class AppStrings {
  static const appTitle = 'To-Do App';
  static const emptyTodos = 'No To-Dos found';
  static const searchHint = 'Search todos...';
  static const todoDetailTitle = 'To-Do Details';
  static const completion = 'completed';
  static const notCompletion = 'not completed';
  //loginPage
  static const loginTitle = 'Login';
static String greeting(String username) {
    return username.isNotEmpty ? 'Hello, $username' : appTitle;
  }

}

