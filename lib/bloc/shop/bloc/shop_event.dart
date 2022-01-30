part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}

class GetDataHome extends ShopEvent {}

class GetCategories extends ShopEvent {}

class ChangeFavoritesEvent extends ShopEvent {
  int? id;
  ChangeFavoritesEvent({this.id});
}

class GetFavouritesEvent extends ShopEvent {}

class GetProfileEvent extends ShopEvent {}
