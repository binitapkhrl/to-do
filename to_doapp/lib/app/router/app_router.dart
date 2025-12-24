import 'package:beamer/beamer.dart';
import 'package:to_doapp/app/location/todo_location.dart';
import 'package:to_doapp/app/router/routes.dart';
import 'package:to_doapp/features/state/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Change to autoDispose so it cleans up after itself
// 1. Remove autoDispose to prevent the "Bad State" during transitions
final routerDelegateProvider = Provider<BeamerDelegate>((ref) {
  // 1. Create the delegate ONCE. 
  // Notice we do NOT ref.watch at the top level here anymore.
  final delegate = BeamerDelegate(
    initialPath: Routes.login,
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [TodoLocation()],
    ).call,
    guards: [
      // Guard for /todos
      BeamGuard(
        pathPatterns: ['/todos', '/todos/*'],
        check: (context, state) => ref.read(isAuthenticatedProvider),
        beamToNamed: (origin, target) => Routes.login,
      ),
      // Guard for /login
      BeamGuard(
        pathPatterns: [Routes.login],
        check: (context, state) => !ref.read(isAuthenticatedProvider),
        beamToNamed: (origin, target) => Routes.todos,
      ),
    ],
  );

  // 2. THE REACTION: Listen to the state change.
  // Instead of rebuilding the provider, we just tell the existing
  // delegate to "update" itself.
  ref.listen<bool>(isAuthenticatedProvider, (previous, next) {
    // This allows the current frame to finish before navigating,
    // which prevents the "Bad State" error.
    Future.microtask(() {
      delegate.update(); 
    });
  });

  return delegate;
});