import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/favorites.dart';

import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:softagi/shared/components/network/repository.dart';
import 'package:softagi/shared/constants.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  Map<int?, dynamic>? isFavorites = {};
  HomeModel? homeModel;
  CategoriesModel? categories;
  Favorites? favoritesModel;
  Repository? repo;
  // var CachIMG;
  var favouritesGET;
  FavouritesModel? Favourites;
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) {});
    on<FavouritesGetEvent>((event, emit) async {
      emit(FavoritesLoadingState());
      //var data = await DioHelper.getData(url: HOME, token: token);
      isFavorites = await Repository.getFav();
      favouritesGET = await DioHelper.getData(url: GET_FAVORITES, token: token);
      Favourites = FavouritesModel.fromJson(favouritesGET.data);
      // homeModel!.data!.products!.forEach((e) {
      //   CacheHelper.saveData(key: 'image ${e.id}', value: '${e.image}');
      //   CachIMG = CacheHelper.getData(key: 'image ${e.id}');
      // });
      //homeModel = HomeModel.fromJson(data.data);
      // homeModel!.data!.products!.forEach((element) {
      //   isFavorites!.addAll({element.id: element.inFavorites});
      // });

      // print(isFavorites);
      if (favouritesGET != null) {
        emit(GetFavoritesSuccessState1(model: Favourites));
      } else {
        emit(GetFavoritesErrorState());
      }
    });
    // on<ChangeFavoritesEvent1>((event, emit) async {
    //   isFavorites![event.id] = !(isFavorites![event.id]);
    //   var data = await DioHelper.getData(url: HOME, token: token);
    //   var category = await DioHelper.getData(url: GET_CATEGORY);
    //   homeModel = HomeModel.fromJson(data.data);
    //   categories = CategoriesModel.fromJson(category.data);

    //   var fav = await DioHelper.postData(
    //       url: GET_FAVORITES, data: {'product_id': event.id}, token: token);
    //   favoritesModel = Favorites.fromJson(fav.data);
    //   if (!(Favourites!.status!)) {
    //     isFavorites![event.id] = !(isFavorites![event.id]);
    //   }
    //   print(isFavorites);
    //   emit(ChangeFavoritesSuccessState1(
    //       fav: favoritesModel, categories: categories, homeModel: homeModel));
    // });
    on<FavouritesDeleteEvent>((event, emit) async {
      // print(isFavorites);
      var data = await DioHelper.deleteData(
          url: GET_FAVORITES, id: event.id, token: token);
      Favourites = FavouritesModel.fromJson(data.data);
      // print(data);
      isFavorites = await Repository.getFav();
      emit(DeleteFavoritesState());

      // print(isFavorites);
    });
  }
}
