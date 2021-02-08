import 'package:flutter/material.dart';
import 'package:rocket_movies/blocs/home_bloc.dart';
import 'package:rocket_movies/widgets/my_stream_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* Declaration of variables*/
  final HomeBloc bloc = HomeBloc();

  /* On initiate the screen run a query to get the list of movies */
  @override
  void initState() {
    bloc.getMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.blue,
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height,
      ),
      appBar: AppBar(title: Text('Rocket Movies')),
      body: myStreamBuilder(
        context: context,
        stream: bloc.movies,
        // Show a progress indicator
        onLoad: Center(child: CircularProgressIndicator()),
        // Show a message explaining that don't have any movie close to release
        withDataEmpty: Container(color: Colors.green),
        withValidData: Container(color: Colors.red),
      )
    );
  }
}