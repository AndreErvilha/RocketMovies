import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rocket_movies/api/api.dart';
import 'package:rxdart/rxdart.dart';

class DetailsBloc extends BlocBase {
  /* Make this object unique instantiable */
  // internal constructor
  DetailsBloc._internal();

  // initialize the instance variable
  static final DetailsBloc _instance = DetailsBloc._internal();
  int pagination = 1;

  // factory responsible to return the singleton
  factory DetailsBloc() {
    return _instance;
  }

  // instantiate a singleton of Api object
  final Api _api = Api();

  /* Streams declarations */
  BehaviorSubject<Map> _details = BehaviorSubject<Map>();

  Stream<Map> get details => _details.stream;

  /* Disposes */
  @override
  void dispose() {
    _details.close();

    super.dispose();
  }

  /* Functions */
  Future<void> getDetails(int id) async {
    Map myReturn;

    // set data as null indicating "request on progress"
    _details.sink.add(null);

    // Request data and show an error on "catchError"
    Response res = await _api.get(
      'movie/$id',
      queryParameters: <String, dynamic>{
        'api_key': 'a351c734af021246a5830a91378544e4',
        'language': 'pt-BR',
      },
    ).catchError((e) {
      print('Error on data acquisition!, error: $e');
      _details.addError('Error on data acquisition!');
    });

    // If the request return null set as an empty List -> []
    try {
      myReturn = jsonDecode(res.toString());
      _details.sink.add(myReturn);
    } catch (e) {
      print('Error on data json decode!, error: $e');
      _details.addError('Error on data json decode!');
    }
  }
}