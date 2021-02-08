import 'package:dio/dio.dart';

class Api {
  Dio _http;
  static const base_url = "https://dev.movpass.com.br/api/";

  Api._internal() {
    this._http = Dio(BaseOptions(
      baseUrl: base_url,
      contentType: 'application/json',
      // Note: On last review of Dio plugin (3.0.10) was implemented an
      // automatic parse the data to "Map" Object when "responseType" parameter
      // were "ResponseType.json", to avoid this is needed set "responseType"
      // as "ResponseType.plain".
      responseType: ResponseType.plain,
      validateStatus: (int statusCode) => statusCode >= 200 && statusCode < 300,
      receiveTimeout: 5000,
      sendTimeout: 5000,
      connectTimeout: 5000,
    ));
  }

  static final Api _instance = Api._internal();

  factory Api() => _instance;

  void onError(error) {
    throw error;
  }

  Future<Response> get(String path, {Map<dynamic, dynamic> queryParameters}) async {
    Response res = await _http
        .get(base_url + path, queryParameters: queryParameters)
        .catchError(onError);
    return res;
  }
}
