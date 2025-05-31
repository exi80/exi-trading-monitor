import 'package:flutter/material.dart';

void main() {
  runApp(const TradingMonitorApp());
}

class TradingMonitorApp extends StatelessWidget {
  const TradingMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EXI Handelsmonitor',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text('Kontostände folgen hier...'),
        ),
      ),
    );
  }
}