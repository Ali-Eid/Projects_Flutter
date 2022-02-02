import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/favorites.dart';
import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/models/search_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  Map<int?, dynamic> isFavourite = {};

  void getDataHome() {
    emit(ShopLoadingHomePage());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        isFavourite.addAll({element.id: element.inFavorites});
      });
      emit(ShopSuccessHomePage());
    }).catchError((error) {
      emit(ShopErrorHomePage(error: error));
    });
  }

  CategoriesModel? category;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORY, token: token).then((value) {
      category = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategory());
    }).catchError((error) {
      emit(ShopErrorCategory(error: error));
    });
  }

  Favorites? fav;
  void changeFavourite(int? prouductId) {
    isFavourite[prouductId] = !isFavourite[prouductId];
    emit(ShopChangeFavourites());
    DioHelper.postData(
            url: GET_FAVORITES, data: {'product_id': prouductId}, token: token)
        .then((value) {
      fav = Favorites.fromJson(value.data);
      if (!(fav!.status!)) {
        isFavourite[prouductId] = !isFavourite[prouductId];
      } else {
        getFavourites();
      }

      emit(ShopSuccessChangeFavourites(fav: fav));
    }).catchError((error) {
      isFavourite[prouductId] = !isFavourite[prouductId];
      emit(ShopErrorChangeFavourites(error: error));
    });
  }

  FavouritesModel? favourites;

  void getFavourites() {
    emit(ShopLoadingGetFavourites());
    DioHelper.getData(url: GET_FAVORITES, token: token).then((value) {
      favourites = FavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavourites());
    }).catchError((error) {
      emit(ShopErrorGetFavourites(error: error));
    });
  }

  LoginModel? userModel;

  void getProfile() {
    emit(ShopLoadingGetProfile());
    DioHelper.getData(url: GET_PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetProfile(userModel: userModel));
    }).catchError((error) {
      emit(ShopErrorGetFavourites(error: error));
    });
  }
}
