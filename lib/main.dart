import 'package:flutter/material.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/screens/home_screen.dart';
import '../screens/auth_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF006064),
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF006064),
        brightness: Brightness.dark,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      themeMode: ThemeMode.system,
      home:  HomeScreen(),
    );
  }  }