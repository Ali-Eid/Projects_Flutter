part of 'shop_bloc.dart';

@immutable
abstract class ShopState {
  HomeModel? homeModel;
  CategoriesModel? categories;
}

class ShopInitial extends ShopState {}

class ShopSuccessHomePage extends ShopState {
  HomeModel? homeModel;
  CategoriesModel? categories;
  ShopSuccessHomePage({this.homeModel, this.categories});
}

class ShopErrorHomePage extends ShopState {}

class ShopLoadingHomePage extends ShopState {}

class ShopLoadingCAtegoriesPage extends ShopState {}

class CategoriesSuccessState extends ShopState {
  // HomeModel? homeModel;

  CategoriesModel? categories;
  CategoriesSuccessState({this.categories});
}

class CategoriesErrorState extends ShopState {}

class ChangeFavoritesSuccessState extends ShopState {
  HomeModel? homeModel;
  CategoriesModel? categories;
  Favorites? fav;
  ChangeFavoritesSuccessState({this.fav, this.categories, this.homeModel});
}

class ChangeFavoritesErrorState extends ShopState {}

class GetFavoritesSuccessState extends ShopState {
  FavouritesModel? model;
  GetFavoritesSuccessState({this.model});
}

class GetFavoritesErrorState extends ShopState {}

class GetProfileErrorState extends ShopState {}

class GetProfileState extends ShopState {
  HomeModel? homeModel;
  CategoriesModel? categories;
  LoginModel? model;
  GetProfileState({this.model, this.homeModel, this.categories});
}
