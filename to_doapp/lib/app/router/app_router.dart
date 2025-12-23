import 'package:beamer/beamer.dart';
import 'package:to_doapp/app/location/todo_location.dart';
import 'package:to_doapp/app/router/routes.dart';

class AppRouter {
  // Route paths (delegated to `Routes` to avoid duplication)
  static const String home = Routes.home;
  static const String todos = Routes.todos;
  static const String todoDetail = Routes.todoDetail;

  static final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        TodoLocation(),
      ],
    ),
  );
}

