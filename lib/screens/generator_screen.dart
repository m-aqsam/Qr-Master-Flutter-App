import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/history_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_application_1/widgets/custom_text_field.dart';
import 'package:flutter_application_1/widgets/gradient_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GeneratorScreen extends StatefulWidget {
  const GeneratorScreen({super.key});

  @override
  State<GeneratorScreen> createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  final TextEditingController _controller = TextEditingController();
  String _data = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _controller,
              label: 'Enter Content',
              icon: Icons.link_rounded,
              onChanged: (value) {
                setState(() {
                  _data = value;
                });
              },
            ).animate().fadeIn().slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 32),

            if (_data.isNotEmpty) ...[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: QrImageView(
                    data: _data,
                    version: QrVersions.auto,
                    size: 200.0,
                    // Simple default style, uses primary color if needed but standard is black usually for high contrast.
                    // User said "simple like before", effectively removing customization.
                    // We can use primary color for a slight touch or just black. Let's use black for max compatibility/simple.
                  ),
                ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   GradientButton(
                    onPressed: () {
                      if (_data.isNotEmpty) {
                         Share.share(_data);
                         HistoryService().addToHistory(_data, 'GENERATE');
                      }
                    },
                    text: 'Share',
                    icon: Icons.share_rounded,
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(width: 16),
                  GradientButton(
                    onPressed: () {
                      if (_data.isNotEmpty) {
                         HistoryService().addToHistory(_data, 'GENERATE');
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Saved to History')),
                         );
                      }
                    },
                    text: 'Save',
                    icon: Icons.save_alt_rounded,
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ] else 
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    Icon(
                      Icons.qr_code_2_rounded, 
                      size: 100, 
                      color: Theme.of(context).disabledColor.withValues(alpha: 0.3)
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Enter text to generate QR code',
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ).animate().fadeIn(),
              ),
          ],
        ),
      ),
    );
  }
}
