import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {

  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  // Future<dynamic> get (String url, {required Map headers}) {
  //   return http.get(url, headers: headers as Map<String, String>).then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;
  //
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return _decoder.convert(res);
  //   });
  // }


  Future<dynamic> get (String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {required Map headers, body, required encoding}) {
    return http
        .post(Uri.parse(url), body: body, headers: headers as Map<String, String>, encoding: encoding)
        .then((http.Response response) {
      final String  res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print(statusCode);
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}