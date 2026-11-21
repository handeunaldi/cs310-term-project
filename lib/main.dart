import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/sign_up_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pick_spots_screen.dart';
import 'screens/your_picks_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const PlacesToGoApp());
}

class PlacesToGoApp extends StatelessWidget {
  const PlacesToGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places To Go',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/spots': (context) => const PickSpotsScreen(),
        '/picks': (context) => const YourPicksScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
