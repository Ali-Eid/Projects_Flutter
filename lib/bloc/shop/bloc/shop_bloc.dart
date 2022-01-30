import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/favorites.dart';
import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/modules/favorite/favorite_screen.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:softagi/shared/constants.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  HomeModel? homeModel;
  CategoriesModel? categories;
  Map<int?, dynamic?> isFavorites = {};
  Favorites? favoritesModel;
  LoginModel? loginModel;
  FavouritesModel? Favourites;
  var CachIMG;
  ShopBloc() : super(ShopInitial()) {
    on<ShopEvent>((event, emit) async {});
    on<GetDataHome>((event, emit) async {
      emit(ShopLoadingHomePage());
      var data = await DioHelper.getData(url: HOME, token: token);
      var category = await DioHelper.getData(url: GET_CATEGORY);
      homeModel = HomeModel.fromJson(data.data);
      categories = CategoriesModel.fromJson(category.data);
      homeModel!.data!.products!.forEach((element) {
        isFavorites.addAll({element.id: element.inFavorites});
      });
      homeModel!.data!.products!.forEach((e) {
        CacheHelper.saveData(key: 'image ${e.id}', value: '${e.image}');
        CachIMG = CacheHelper.getData(key: 'image ${e.id}');
      });

      on<GetProfileEvent>((event, emit) async {
        var profData = await DioHelper.getData(url: GET_PROFILE, token: token);
        loginModel = LoginModel.fromJson(profData.data);
        if (loginModel != null) {
          emit(GetProfileState(
              model: loginModel, homeModel: homeModel, categories: categories));
        } else {
          emit(GetProfileErrorState());
        }
      });
      if (data != null) {
        emit(ShopSuccessHomePage(homeModel: homeModel, categories: categories));
      } else {
        emit(ShopErrorHomePage());
      }
    });
    on<ChangeFavoritesEvent>((event, emit) async {
      isFavorites[event.id] = !(isFavorites[event.id]);
      var data = await DioHelper.getData(url: HOME, token: token);
      var category = await DioHelper.getData(url: GET_CATEGORY);
      homeModel = HomeModel.fromJson(data.data);
      categories = CategoriesModel.fromJson(category.data);

      var fav = await DioHelper.postData(
          url: GET_FAVORITES, data: {'product_id': event.id}, token: token);
      favoritesModel = Favorites.fromJson(fav.data);
      if (!(favoritesModel!.status!)) {
        isFavorites[event.id] = !(isFavorites[event.id]);
      }
      print(isFavorites);
      emit(ChangeFavoritesSuccessState(
          fav: favoritesModel, categories: categories, homeModel: homeModel));
    });
  }
}
