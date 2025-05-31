import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading Monitor',
      theme: ThemeData.dark(),
      home: TradingStatusScreen(),
    );
  }
}

class TradingStatusScreen extends StatefulWidget {
  @override
  _TradingStatusScreenState createState() => _TradingStatusScreenState();
}

class _TradingStatusScreenState extends State<TradingStatusScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic>? accounts;

  @override
  void initState() {
    super.initState();
    _database.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && mounted) {
        setState(() => accounts = Map<dynamic, dynamic>.from(data as Map));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trading Monitor'),
        centerTitle: true,
      ),
      body: accounts == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: accounts!.entries.map((entry) {
                final value = Map<String, dynamic>.from(entry.value);
                final equity = value['equity'] ?? 0.0;
                final balance = value['balance'] ?? 0.0;
                final diff = (equity - balance).toStringAsFixed(2);
                final isGain = equity >= balance;
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text('Konto: ${value['konto']}', style: TextStyle(color: Colors.white)),
                    subtitle: Text('Balance: ${balance.toStringAsFixed(2)}', style: TextStyle(color: Colors.white70)),
                    trailing: Text(
                      '${isGain ? '+' : ''}$diff',
                      style: TextStyle(
                        fontSize: 16,
                        color: isGain ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
