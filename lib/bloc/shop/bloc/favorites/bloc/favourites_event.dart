part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent {}

class GetFavorites extends FavouritesEvent {
  int? id;
  GetFavorites({this.id});
}

class FavouritesGetEvent extends FavouritesEvent {}

class ChangeFavoritesEvent1 extends FavouritesEvent {
  int? id;
  ChangeFavoritesEvent1({this.id});
}

class FavouritesDeleteEvent extends FavouritesEvent {
  int? id;
  FavouritesDeleteEvent({this.id});
}
