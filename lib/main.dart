import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EXI Trading Monitor',
      theme: ThemeData.dark(),
      home: const TradingMonitorScreen(),
    );
  }
}

class TradingMonitorScreen extends StatefulWidget {
  const TradingMonitorScreen({super.key});

  @override
  State<TradingMonitorScreen> createState() => _TradingMonitorScreenState();
}

class _TradingMonitorScreenState extends State<TradingMonitorScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<String, dynamic> accounts = {};

  @override
  void initState() {
    super.initState();
    _database.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      setState(() {
        accounts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset('assets/images/logo.png', height: 60),
            ),
            const Text('EXI Trading Monitor',
                style: TextStyle(color: Colors.white, fontSize: 22)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: accounts.entries.map((entry) {
                  final konto = entry.key;
                  final data = Map<String, dynamic>.from(entry.value);
                  final double balance = data['balance'] ?? 0;
                  final double equity = data['equity'] ?? 0;
                  final double profit = data['profit'] ?? 0;

                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: ListTile(
                      title: Text('Konto $konto',
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        'Balance: ${balance.toStringAsFixed(2)}
Equity: ${equity.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Text(
                        '${profit.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: profit >= 0 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
