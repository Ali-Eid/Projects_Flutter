import 'package:dio/dio.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/constants.dart';

class Repository {
  static Dio? dio;
  static Map<int?, dynamic> favList = {};
  static HomeModel? homeModel;

  static Future<Map<int?, dynamic>?> getFav() async {
    var data = await DioHelper.getData(url: HOME, token: token);
    homeModel = HomeModel.fromJson(data.data);
    homeModel!.data!.products!.forEach((element) {
      favList.addAll({element.id: element.inFavorites});
    });
    return favList;
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
    // favList = Repository.getFav();
    return await dio!.delete('${url}/${id}');
  }
}
