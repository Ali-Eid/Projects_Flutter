part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ShopSuccessHomePage extends HomeState {
  // HomeModel? homeModel;
  // CategoriesModel? categories;
  // ShopSuccessHomePage({this.homeModel});
}

class ShopErrorHomePage extends HomeState {
  String? error;
  ShopErrorHomePage({this.error});
}

class ShopLoadingHomePage extends HomeState {}

class ShopSuccessCategory extends HomeState {
  CategoriesModel? cat;
  ShopSuccessCategory({this.cat});
}

class ShopErrorCategory extends HomeState {
  String? error;
  ShopErrorCategory({this.error});
}

class ShopChangeFavourites extends HomeState {}

class ShopSuccessChangeFavourites extends HomeState {
  Favorites? fav;
  ShopSuccessChangeFavourites({this.fav});
}

class ShopErrorChangeFavourites extends HomeState {
  String? error;
  ShopErrorChangeFavourites({this.error});
}

class ShopLoadingGetFavourites extends HomeState {}

class ShopSuccessGetFavourites extends HomeState {}

class ShopErrorGetFavourites extends HomeState {
  String? error;
  ShopErrorGetFavourites({this.error});
}

class ShopLoadingGetProfile extends HomeState {}

class ShopSuccessGetProfile extends HomeState {
  LoginModel? userModel;
  ShopSuccessGetProfile({this.userModel});
}

class ShopErrorGetProfile extends HomeState {}
