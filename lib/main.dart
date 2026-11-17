import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

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
      home: Scaffold(
        body: Center(child: Text('Places To Go')),
        ),
      );
  }
}