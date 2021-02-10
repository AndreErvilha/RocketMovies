import 'package:flutter/material.dart';
import 'package:rocket_movies/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Welcome(),
    );
  }
}