import 'package:flutter/material.dart';
import 'screens/auth_page.dart'; // ⬅️ ganti import

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Plant',
      theme: ThemeData(primarySwatch: Colors.green),
      home: AuthPage(), // ⬅️ ganti di sini
    );
  }
}
