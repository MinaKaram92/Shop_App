import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/end_points.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryparams,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: queryparams,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryparams,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      data: data,
      queryParameters: queryparams,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? queryparams,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.put(
      url,
      data: data,
      queryParameters: queryparams,
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? queryparams,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.delete(
      url,
      queryParameters: queryparams,
    );
  }
}
