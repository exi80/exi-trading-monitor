
import 'package:flutter/material.dart';

void main() => runApp(const TradingMonitorApp());

class TradingMonitorApp extends StatelessWidget {
  const TradingMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading Monitor',
      theme: ThemeData.dark(),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Trading Monitor',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
