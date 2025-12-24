import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to store the current logged-in username
final currentUsernameProvider = StateProvider<String?>((ref) => null);
