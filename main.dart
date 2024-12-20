import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mark It Right Game',
      theme: ThemeData(
        primarySwatch: Colors.orange, // App-wide orange theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            minimumSize: Size(200, 50),
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
        ),
      ),
      home: HomePage(), // The HomePage widget is set here
    );
  }
}