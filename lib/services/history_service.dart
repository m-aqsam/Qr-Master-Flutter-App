import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryItem {
  final String data;
  final String type; // 'SCAN' or 'GENERATE'
  final DateTime timestamp;

  HistoryItem({
    required this.data,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'data': data,
    'type': type,
    'timestamp': timestamp.toIso8601String(),
  };

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    data: json['data'],
    type: json['type'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}

class HistoryService {
  static const String _key = 'qr_history';

  Future<List<HistoryItem>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawInfo = prefs.getStringList(_key) ?? [];
    return rawInfo
        .map((e) => HistoryItem.fromJson(jsonDecode(e)))
        .toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<void> addToHistory(String data, String type) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawInfo = prefs.getStringList(_key) ?? [];
    
    final newItem = HistoryItem(
      data: data,
      type: type,
      timestamp: DateTime.now(),
    );
    
    // Avoid duplicates at top
    if (rawInfo.isNotEmpty) {
      final last = HistoryItem.fromJson(jsonDecode(rawInfo.last));
      if (last.data == data && last.type == type) return;
    }

    rawInfo.add(jsonEncode(newItem.toJson()));
    await prefs.setStringList(_key, rawInfo);
  }
    
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
