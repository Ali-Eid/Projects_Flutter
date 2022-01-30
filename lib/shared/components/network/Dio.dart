import 'package:dio/dio.dart';
import 'package:softagi/shared/components/network/cache.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // receiveTimeout: 600 * 1000,
        // connectTimeout: 600 * 1000,
        // headers: {'Content-Type': 'application/json', 'lang': 'en'}
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? queryparameters,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = lang;
    dio!.options.headers['Authorization'] = token;
    return await dio!.get(url, queryParameters: queryparameters);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? queryparameters,
    required dynamic data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = lang;
    dio!.options.headers['Authorization'] = token;
    return await dio!.post(url, data: data, queryParameters: queryparameters);
  }

  static Future<Response> deleteData({
    required String url,
    required int? id,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers['Content-Type'] = 'application/json';
    dio!.options.headers['lang'] = lang;
    dio!.options.headers['Authorization'] = token;
    return await dio!.delete('${url}/${id}');
  }
}
