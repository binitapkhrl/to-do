import 'package:beamer/beamer.dart';
import 'package:to_doapp/app/location/todo_location.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/features/state/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- MOVE THIS OUTSIDE THE CLASS ---
final routerDelegateProvider = Provider<BeamerDelegate>((ref) {
  return BeamerDelegate(
    initialPath: Routes.login,
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [TodoLocation()],
    ).call,
    guards: [
      // PROTECT TODOS: Redirect to login if not authenticated
      BeamGuard(
        pathPatterns: ['/todos', '/todos/*'],
        check: (context, state) => ref.watch(isAuthenticatedProvider),
        beamToNamed: (origin, target) => Routes.login,
      ),
      
      // Prevent logged-in users from going back to Login page
      BeamGuard(
        pathPatterns: [Routes.login],
        check: (context, state) => !ref.watch(isAuthenticatedProvider),
        beamToNamed: (origin, target) => Routes.todos,
      ),
    ],
  );
});

class AppRouter {
  // Static paths remain here
  static const String home = Routes.login;
  static const String todos = Routes.todos;
  static const String todoDetail = Routes.todoDetail;
  static String todoDetailPath(String username, int id) => Routes.todoDetailPath(username, id);
}