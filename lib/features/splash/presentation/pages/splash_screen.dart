import 'dart:async';
import 'package:ceniflix/core/services/storage/user_session_service.dart';
import 'package:ceniflix/features/dashboard/presentation/pages/home_screen.dart';
import 'package:ceniflix/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();

    // Animation for logo
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Decide navigation after splash
    _decideNavigation();
  }

  Future<void> _decideNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // Check SharedPreferences for login state
    final userSession = ref.read(userSessionServiceProvider);
    final isLoggedIn = userSession.isLoggedIn();

    if (isLoggedIn) {
      // If logged in, go directly to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      // If not logged in, go to Onboarding / Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB30000),
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/cineflixlogo.PNG",
                width: 140,
                height: 140,
              ),
              const SizedBox(height: 18),
              const Text(
                "CINEFLIX",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
