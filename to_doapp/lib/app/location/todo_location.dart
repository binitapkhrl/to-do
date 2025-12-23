import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../features/presentation/pages/todo_page.dart';
import '../../features/presentation/pages/todo_detail_page.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/features/presentation/pages/todo_login.dart';

// class TodoLocation extends BeamLocation<BeamState> {
//   @override
//   List<String> get pathPatterns => [
//         Routes.login,
//         Routes.todos,
//         Routes.todoDetail,
//       ];

//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     final pages = <BeamPage>[
//       const BeamPage(
//         key: ValueKey('todo-list'),
//         title: 'Todos',
//         child: TodoListPage(),
//       ),
//     ];

//     if (state.uri.pathSegments.length == 2) {
//       final todoId = int.parse(state.uri.pathSegments.last);

//       pages.add(
//         BeamPage(
//           key: ValueKey('todo-$todoId'),
//           title: 'Todo Detail',
//           child: TodoDetailPage(
//             todoId: todoId,
//           ),
//         ),
//       );
//     }

//     return pages;
//   }
// }
// lib/app/location/todo_location.dart
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

    // Always show Login if the path is exactly '/'
    if (state.uri.path == Routes.login) {
      pages.add(
        const BeamPage(
          key: ValueKey('login'),
          title: 'Login',
          child: LoginPage(),
        ),
      );
    }

    // If the path contains 'todos', we build the Todo stack
    if (state.uri.path.contains(Routes.todos)) {
      pages.add(
        const BeamPage(
          key: ValueKey('todo-list'),
          title: 'Your Todos',
          child: TodoListPage(),
        ),
      );

      // If there is an ID in the URL, push the Detail Page on top
      if (state.uri.pathSegments.length == 2) {
        final todoId = int.tryParse(state.uri.pathSegments.last);
        if (todoId != null) {
          pages.add(
            BeamPage(
              key: ValueKey('todo-$todoId'),
              title: 'Details',
              child: TodoDetailPage(todoId: todoId),
            ),
          );
        }
      }
    }

    return pages;
  }
}