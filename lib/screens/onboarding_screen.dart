import 'package:flutter/material.dart';
import 'package:ceniflix/models/onboarding_model.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  void _goNext() {
    if (_index < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB30000),
              Color(0xFF7A0000),
              Color(0xFF2B0000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _finish,
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingPages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) {
                    final page = onboardingPages[i];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/icons/cineflixlogo.PNG",
                              width: 170,
                              height: 170,
                              fit: BoxFit.contain,
                            ),
                          ),

                          const Spacer(),

                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              page.icon,
                              size: 70,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(height: 35),

                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingPages.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 7,
                    width: _index == i ? 20 : 7,
                    decoration: BoxDecoration(
                      color: _index == i ? Colors.cyanAccent : Colors.white30,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE10000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _goNext,
                    child: Text(
                      _index == onboardingPages.length - 1
                          ? "Get Started"
                          : "Next",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
