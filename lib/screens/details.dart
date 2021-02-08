import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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