import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SecretPoliceApp());
}

class SecretPoliceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secret Police App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
