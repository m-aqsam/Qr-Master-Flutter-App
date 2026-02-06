import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Corners
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Animated Line
        Center(
          child: Container(
            width: 240,
            height: 2,
            decoration: BoxDecoration(
              gradient: AppColors.scanLineGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.error.withValues(alpha: 0.5),
                  blurRadius: 10,
                )
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .moveY(begin: -120, end: 120, duration: 2.seconds, curve: Curves.easeInOut),
        ),
      ],
    );
  }
}
