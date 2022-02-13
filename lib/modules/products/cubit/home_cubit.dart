import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/cart_model.dart';
import 'package:softagi/models/categories_details.dart';

import 'package:softagi/models/category.dart';
import 'package:softagi/models/favorites.dart';
import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/login_model.dart';
import 'package:softagi/models/product_details.dart';
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
  Map<int?, dynamic> isCart = {};

  void getDataHome() {
    emit(ShopLoadingHomePage());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        isCart.addAll({element.id: element.inCart});
        isFavourite.addAll({element.id: element.inFavorites});
        // isCart.addAll({element.id: element.inCart});
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

  CategoriesModel? modelCategory;
  void getDataCategory(int? id) {
    emit(ShopLoadingDetailsCategory());
    DioHelper.getData(
      url: 'categories/${id}',
      // queryparameters: {'category_id': 44},
      token: token,
    ).then((value) {
      modelCategory = CategoriesModel.fromJson(value.data);
      print(modelCategory!.data!.data!.length);
      emit(ShopSuccessDetailsCategory());
    }).catchError((error) {
      print("progress Error");
      emit(ShopErrorDetailsCategory());
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

  Favorites? cart;

  void changeCart(int? prouductId) {
    isCart[prouductId] = !isCart[prouductId];
    emit(ShopChangeCartState());
    DioHelper.postData(
            url: GET_CARTS, data: {'product_id': prouductId}, token: token)
        .then((value) {
      cart = Favorites.fromJson(value.data);
      if (!(cart!.status!)) {
        isCart[prouductId] = !isCart[prouductId];
        // getCart();
      } else {
        getCart();
      }

      emit(ShopChangeSuccessCartState());
    }).catchError((error) {
      isCart[prouductId] = !isCart[prouductId];
      emit(ShopChangeErrorCartState());
    });
  }

  CartModel? cartModel;

  void getCart() {
    emit(ShopLoadingGetCarts());
    DioHelper.getData(url: GET_CARTS, token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessGetCarts());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetCarts(error: error));
    });
  }

  // ProductsDetails? modelProduct;
  // void getDataProducts(int? id) {
  //   emit(ShopLoadingDetails());
  //   DioHelper.getData(url: 'products/${id}', token: token).then((value) {
  //     modelProduct = ProductsDetails.fromJson(value.data);
  //     print(modelProduct!.data!.id);
  //     emit(ShopSuccessDetails());
  //   }).catchError((error) {
  //     // print("progress Error");
  //     emit(ShopErrorDetails());
  //   });
  // }
}
