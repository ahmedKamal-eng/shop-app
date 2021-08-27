import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio; //write static to use it in init which it a static method

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json', 'lang': 'en'}),
    );
  }

  static Future<Response> get(
      {@required String url, @required Map<String, dynamic> query}) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {
        @required String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      String lang = 'ar',
      String token}) async {
    dio.options.headers = {'lang': lang, 'Authorization': token};

    return dio.post(url, queryParameters: query, data: data);
  }
}
