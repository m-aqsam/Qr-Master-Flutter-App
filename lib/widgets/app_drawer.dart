import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/theme_service.dart';
import 'package:flutter_application_1/utils/constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_2_rounded,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'QR Master',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6_rounded),
            title: const Text('Dark Mode'),
            trailing: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeService().themeMode,
              builder: (context, mode, child) {
                return Switch(
                  value: mode == ThemeMode.dark,
                  activeThumbColor: AppColors.primary,
                  onChanged: (value) {
                    ThemeService().updateTheme(value ? ThemeMode.dark : ThemeMode.light);
                  },
                );
              },
            ),
          ),
          const Divider(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'Developed by',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    // Optional: Link to social profile if needed
                  },
                  child: Text(
                    '@aqsam',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
