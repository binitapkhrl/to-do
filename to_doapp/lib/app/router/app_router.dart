import 'package:beamer/beamer.dart';
import 'package:to_doapp/app/location/todo_location.dart';
import 'package:to_doapp/app/router/routes.dart';

class AppRouter {
  // Route paths (delegated to `Routes` to avoid duplication)
  static const String home = Routes.login;
  static const String todos = Routes.todos;
  static const String todoDetail = Routes.todoDetail;
  static String todoDetailPath(String username, int id) => Routes.todoDetailPath(username, id);

static final routerDelegate = BeamerDelegate(
  initialPath: Routes.login,
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [TodoLocation()],
  ).call,
  guards: [
    // PROTECT TODOS: Redirect to login if not authenticated
    BeamGuard(
      pathPatterns: ['/todos*'],
      check: (context, state) {
        return true; 
      },
      beamToNamed: (origin, target) => Routes.login,
    ),
  ],
);
}

