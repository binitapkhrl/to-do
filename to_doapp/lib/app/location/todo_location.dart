import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../features/presentation/pages/todo_page.dart';
import '../../features/presentation/pages/todo_detail_page.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/features/presentation/pages/todo_login.dart';

class TodoLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        Routes.login,
        Routes.todos,
        Routes.todoDetail,
      ];
 @override
List<BeamPage> buildPages(BuildContext context, BeamState state) {
  final pages = <BeamPage>[];

  // 1. Always show Login if that's the current path
  if (state.uri.path == Routes.login) {
    pages.add(
      const BeamPage(
        key: ValueKey('login'),
        child: LoginPage(),
      ),
    );
    return pages;
  }

  // 2. DEFAULT FALLBACK: If we aren't at login, show the main Todo List
  // Even if there is no username in the URL yet, we show the list.
  final username = state.pathParameters['username'] ?? 'Guest'; // Default if null

  pages.add(
    BeamPage(
      key: ValueKey('todo-$username'),
      child: TodoListPage(username: username),
    ),
  );

  // 3. ADD DETAIL PAGE ON TOP: Only if ID exists
  if (state.pathParameters.containsKey('id')) {
    final todoId = int.parse(state.pathParameters['id']!);
    pages.add(
      BeamPage(
        key: ValueKey('todo-$username-$todoId'),
        child: TodoDetailPage(todoId: todoId),
      ),
    );
  }

  return pages; // This list will now never be empty!
}
}