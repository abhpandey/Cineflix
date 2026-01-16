import 'package:ceniflix/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ceniflix/core/services/storage/user_session_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSession = ref.read(userSessionServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // 1️⃣ Clear current user session
            await userSession.clearSession();

            // 2️⃣ Navigate to signup screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SignupScreen()),
            );
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
