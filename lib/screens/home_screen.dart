import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/generator_screen.dart';
import 'package:flutter_application_1/screens/history_screen.dart';
import 'package:flutter_application_1/screens/scanner_screen.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:flutter_application_1/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    GeneratorScreen(),
    ScannerScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('QR Master'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Theme.of(context).cardColor, // Use cardColor instead of surface for better differentiation if defined, or stick to surface but ensure contrast
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: GNav(
          backgroundColor: Theme.of(context).cardColor,
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : AppColors.textSecondary, // Unselected icon color
          activeColor: Theme.of(context).colorScheme.primary, // Selected icon color
          tabBackgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          gap: 8,
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(icon: Icons.qr_code_2_rounded, text: 'Generate'),
            GButton(icon: Icons.qr_code_scanner_rounded, text: 'Scan'),
            GButton(icon: Icons.history_rounded, text: 'History'),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
