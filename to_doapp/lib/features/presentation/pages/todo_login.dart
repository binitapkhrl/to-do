import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:to_doapp/core/widgets/custom_button.dart';
import 'package:to_doapp/core/widgets/custom_text_field.dart';
import 'package:to_doapp/core/utils/login_utils.dart';
import 'package:to_doapp/features/state/login_provider.dart';
import 'package:to_doapp/app/router/routes.dart'; //

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Hide keyboard on button press
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      await ref.read(loginProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);

    // Listen for state changes for one-time events (Navigation/Snackbars)
    ref.listen<AsyncValue<void>>(loginProvider, (previous, next) {
      next.whenOrNull(
        data: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // 1. Use replacement so user can't "back" into login page
          Beamer.of(context).beamToReplacementNamed(Routes.todos);
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon
                  Hero(
                    tag: 'app_logo',
                    child: Icon(
                      Icons.checklist_rounded,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue to your todos',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 48),

                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: LoginUtils.validateEmail,
                    // Prevent editing while loading
                    enabled: !loginState.isLoading, 
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: LoginUtils.validatePassword,
                    enabled: !loginState.isLoading,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'Login',
                      isLoading: loginState.isLoading,
                      // Disable button while loading
                     onPressed: loginState.isLoading ? null : () => _handleLogin(),
                      borderRadius: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  TextButton(
                    onPressed: loginState.isLoading ? null : () {
                      // Handle forgot password
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}