import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rocket_movies/api/api.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  /* Make this object unique instantiable */
  // internal constructor
  HomeBloc._internal();

  // initialize the instance variable
  static final HomeBloc _instance = HomeBloc._internal();

  // factory responsible to return the singleton
  factory HomeBloc() {
    return _instance;
  }

  // instantiate a singleton of Api object
  final Api _api = Api();

  /* Streams declarations */
  BehaviorSubject<Map> _movies = BehaviorSubject<Map>();

  Stream<Map> get movies => _movies.stream;

  /* Disposes */
  @override
  void dispose() {
    _movies.close();

    super.dispose();
  }

  /* Functions */
  Future<void> getMovies() async {
    Map myReturn;

    // set data as null indicating "request on progress"
    _movies.sink.add(null);

    // Request data and show an error on "catchError"
    Response res = await _api.get(
      'upcoming',
      queryParameters: <String, dynamic>{
        'api_key': 'a351c734af021246a5830a91378544e4',
        'language': 'pt-BR',
        'page': 1,
        'region': 'BR',
      },
    ).catchError((e) {
      print('Error on data acquisition!, error: $e');
      _movies.addError('Error on data acquisition!');
    });

    // If the request return null set as an empty List -> []
    try {
      myReturn = jsonDecode(res.toString());
      _movies.sink.add(myReturn);
    } catch (e) {
      print('Error on data json decode!, error: $e');
      _movies.addError('Error on data json decode!');
    }
  }
}
