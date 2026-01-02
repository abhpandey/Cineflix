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

const List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: "Welcome to CineFlix",
    subtitle: "View what your local cinema is showing.",
    icon: Icons.movie_filter_rounded,
  ),
  OnboardingModel(
    title: "Book the latest Movies",
    subtitle: "Book tickets for the latest movies in just a few taps.",
    icon: Icons.local_fire_department_rounded,
  ),
  OnboardingModel(
    title: "",
    subtitle: " Enjoy seamless booking on the go! hussle-free and convenient.",
    icon: Icons.phone_iphone_rounded,
  ),
];
