// lib/features/state/login_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/todo/repository/auth_repository.dart';

// 1. Create a "AuthState" to track if the user is actually logged in
final isAuthenticatedProvider = StateProvider<bool>((ref) => false);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;
  final StateController<bool> _authState;

  LoginNotifier(this._repository, this._authState) : super(const AsyncData(null));

  Future<void> login(String username, String email, String password) async {
    state = const AsyncLoading();
    
    try {
      final success = await _repository.signIn(username, email, password);
      if (success) {
        _authState.state = true; // Update the global auth state
        state = const AsyncData(null);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void logout() {
    _authState.state = false;
    state = const AsyncData(null);
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(isAuthenticatedProvider.notifier),
  );
});