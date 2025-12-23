import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import '../../features/presentation/pages/todo_page.dart';
import '../../features/presentation/pages/todo_detail_page.dart';
import 'package:to_doapp/app/router/routes.dart';

class TodoLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => [
        Routes.home,
        Routes.todos,
        Routes.todoDetail,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = <BeamPage>[
      const BeamPage(
        key: ValueKey('todo-list'),
        title: 'Todos',
        child: TodoListPage(),
      ),
    ];

    if (state.uri.pathSegments.length == 2) {
      final todoId = int.parse(state.uri.pathSegments.last);

      pages.add(
        BeamPage(
          key: ValueKey('todo-$todoId'),
          title: 'Todo Detail',
          child: TodoDetailPage(
            todoId: todoId,
          ),
        ),
      );
    }

    return pages;
  }
}
