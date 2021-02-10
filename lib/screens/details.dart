import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  /* Local variables */
  final int id;

  /* Constructor */
  Details(this.id);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rocket Movies')),
      body: Container(
        color: Colors.blueGrey,
      ),
    );
  }
}