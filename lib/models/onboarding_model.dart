import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final IconData icon;

  const OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

// Your onboarding pages list
const List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: "Welcome to CineFlix",
    subtitle: "Stream your favorite movies and series anytime.",
    icon: Icons.movie_filter_rounded,
  ),
  OnboardingModel(
    title: "Discover New Content",
    subtitle: "Find trending, top-rated, and recommended shows.",
    icon: Icons.local_fire_department_rounded,
  ),
  OnboardingModel(
    title: "Watch Anywhere",
    subtitle: "Enjoy on your phone, tablet, or big screen.",
    icon: Icons.phone_iphone_rounded,
  ),
];
