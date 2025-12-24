import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_doapp/features/todo/repository/auth_repository.dart';
import 'package:to_doapp/features/state/user_provider.dart';

final isAuthenticatedProvider = StateProvider<bool>((ref) => false);

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _repository;
  final StateController<bool> _authState;
  final StateController<String?> _usernameState;

  LoginNotifier(this._repository, this._authState, this._usernameState) : super(const AsyncData(null));

  Future<void> login(String username, String email, String password) async {
    state = const AsyncLoading();
    
    try {
      final success = await _repository.signIn(username, email, password);
      if (success) {
        _authState.state = true;
        _usernameState.state = username; // Store username
        state = const AsyncData(null);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void logout() {
    _authState.state = false;
    _usernameState.state = null; // Clear username
    state = const AsyncData(null);
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier(
    ref.read(authRepositoryProvider),
    // ref.watch(isAuthenticatedProvider.notifier),
    // ref.watch(currentUsernameProvider.notifier),
    ref.read(isAuthenticatedProvider.notifier),
    ref.read(currentUsernameProvider.notifier),
  
  );
});