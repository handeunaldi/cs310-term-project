import 'package:flutter/material.dart';

import 'models/crew_store.dart';
import 'screens/crews_screen.dart';
import 'screens/explore_screen.dart';
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

class PlacesToGoApp extends StatefulWidget {
  const PlacesToGoApp({super.key});

  @override
  State<PlacesToGoApp> createState() => _PlacesToGoAppState();
}

class _PlacesToGoAppState extends State<PlacesToGoApp> {
  final _crewStore = CrewStore();

  @override
  void dispose() {
    _crewStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places To Go',
      debugShowCheckedModeBanner: false,
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
        '/profile': (context) => ValueListenableBuilder(
          valueListenable: _crewStore,
          builder: (context, crews, child) => ProfileScreen(crews: crews),
        ),
        '/explore': (context) => const ExploreScreen(),
        '/crews': (context) => CrewsScreen(
          store: _crewStore,
          initialSpotCount: ModalRoute.of(context)?.settings.arguments as int?,
        ),
      },
    );
  }
}
