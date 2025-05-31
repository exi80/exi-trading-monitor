
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
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trading Monitor")),
      body: Center(
        child: Text("Firebase verbunden"),
      ),
    );
  }
}
