import 'package:flutter/material.dart';
import 'screen/home.dart'; // Import your Home screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(), // Set Home screen as the initial screen
    );
  }
}
