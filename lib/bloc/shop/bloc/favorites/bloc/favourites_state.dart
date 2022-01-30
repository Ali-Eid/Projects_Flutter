part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState {
  FavouritesModel? model;
  HomeModel? homeModel;
  CategoriesModel? categories;
  Favorites? fav;
  Product? pro;
}

class FavouritesInitial extends FavouritesState {}

class FavoriteSuccessState extends FavouritesState {
  Favorites? fav;
  FavoriteSuccessState({this.fav});
}

class FavoritesErrorState extends FavouritesState {}

class FavoritesLoadingState extends FavouritesState {}

class GetFavoritesErrorState extends FavouritesState {}

class DeleteFavoritesState extends FavouritesState {}

class GetFavoritesSuccessState1 extends FavouritesState {
  FavouritesModel? model;
  GetFavoritesSuccessState1({this.model});
}

class ChangeFavoritesSuccessState1 extends FavouritesState {
  Product? pro;
  HomeModel? homeModel;
  CategoriesModel? categories;
  Favorites? fav;
  ChangeFavoritesSuccessState1(
      {this.fav, this.categories, this.homeModel, this.pro});
}

class ChangeFavoritesErrorState extends FavouritesState {}
