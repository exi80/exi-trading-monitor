import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("EXI TRADING MONITOR", style: TextStyle(color: Colors.white, fontSize: 24)),
              SizedBox(height: 16),
              Text("Kontostand: 5.348,00 €", style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("+328,00 €", style: TextStyle(color: Colors.green, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
