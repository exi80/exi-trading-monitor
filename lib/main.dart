import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TradingMonitorApp());
}

class TradingMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: AccountScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final dbRef = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Exi Kontostände")),
      body: StreamBuilder(
        stream: dbRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map data = Map.from(snapshot.data!.snapshot.value as Map);
            final entries = data.values.toList();
            final unique = <int, Map>{};
            for (var entry in entries) {
              if (entry['konto'] != null) {
                unique[entry['konto']] = Map.from(entry);
              }
            }
            return ListView(
              children: unique.values.map((entry) {
                double profit = double.tryParse(entry['profit'].toString()) ?? 0.0;
                return ListTile(
                  title: Text("Konto: ${entry['konto']}", style: TextStyle(color: Colors.white)),
                  subtitle: Text("Balance: ${entry['balance']}", style: TextStyle(color: Colors.white)),
                  trailing: Text(
                    "${entry['profit']} €",
                    style: TextStyle(
                      color: profit >= 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}