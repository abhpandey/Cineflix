import 'package:ceniflix/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ceniflix/app/themes/themes_data.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: SplashScreen(),
     );
  }
}