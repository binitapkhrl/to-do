// lib/features/auth/data/auth_repository.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
class AuthRepository {
  Future<bool> signIn(String username,String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Valid Credentials
    const validUsername = "testuser";
    const validEmail = "test@test.com";
    const validPassword = "password123";

    if (username == validUsername && email == validEmail && password == validPassword) {
      return true;
    } else {
      throw Exception("Invalid username, email, or password. Hint: testuser / test@test.com / password123");
    }
  }
}

// Provide it
final authRepositoryProvider = Provider((ref) => AuthRepository());