import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height,
      ),
      appBar: AppBar(title: Text('Rocket Movies')),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
