import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/activities_provider.dart';
import 'screens/home_screen.dart';
import 'screens/location_selection_screen.dart';
import 'screens/landing_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KidsListApp());
}

class KidsListApp extends StatelessWidget {
  const KidsListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivitiesProvider(),
      child: MaterialApp(
        title: 'KidsList - Find Children\'s Activities, Camps & Childcare Nationwide',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AppInitializer(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/location': (context) => const LocationSelectionScreen(
                isInitialSetup: false,
              ),
          '/landing': (context) => const LandingPage(),
        },
      ),
    );
  }
}

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, provider, child) {
        // Navigation flow: Landing Page -> Location Selection -> Home
        // Show home directly if location is already set (returning users)
        if (provider.isLocationSet) {
          return const HomeScreen();
        }
        
        // For new users, show landing page first
        return const LandingPage();
      },
    );
  }
}
