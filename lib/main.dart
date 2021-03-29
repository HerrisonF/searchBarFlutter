import 'package:flutter/material.dart';
import 'package:flutter_search_bar/screen/my_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        appBarTheme: AppBarTheme(elevation: 0.0)
      ),
      home: MyHomePage(),
    );
  }
}
