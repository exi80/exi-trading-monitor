import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TradingMonitorApp());
}

class TradingMonitorApp extends StatelessWidget {
  const TradingMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading Monitor',
      theme: ThemeData.dark(),
      home: const AccountScreen(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = FirebaseDatabase.instance.ref('konten/konto1');

    return Scaffold(
      appBar: AppBar(title: const Text('Trading Monitor')),
      body: FutureBuilder(
        future: db.get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          final data = snapshot.data?.value as Map?;
          return Center(
            child: Text('Kontostand: ${data?['balance']}'),
          );
        },
      ),
    );
  }
}