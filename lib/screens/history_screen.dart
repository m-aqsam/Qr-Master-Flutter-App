import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/history_service.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final HistoryService _service = HistoryService();
  List<HistoryItem> _items = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final items = await _service.getHistory();
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.bodyLarge?.color),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: Theme.of(context).textTheme.bodyMedium?.color),
            onPressed: () async {
              await _service.clearHistory();
              _loadHistory();
            },
          ),
        ],
      ),
      body: _items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Theme.of(context).disabledColor.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No history yet',
                    style: TextStyle(color: Theme.of(context).disabledColor),
                  ),
                ],
              ).animate().fadeIn(),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item.type == 'SCAN' 
                            ? AppColors.secondary.withValues(alpha: 0.1) 
                            : AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.type == 'SCAN' ? Icons.qr_code_scanner : Icons.qr_code_2,
                        color: item.type == 'SCAN' ? AppColors.secondary : AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item.data,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    subtitle: Text(
                      _formatDate(item.timestamp),
                      style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.copy, size: 18, color: Theme.of(context).textTheme.bodyMedium?.color),
                      onPressed: () {
                         Clipboard.setData(ClipboardData(text: item.data));
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Copied')),
                         );
                      },
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 50).ms).slideX();
              },
            ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
