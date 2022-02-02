part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class ShopLoadingSearch extends SearchState {}

class ShopSuccessSearch extends SearchState {
  HomeModel? search;
  ShopSuccessSearch({this.search});
}

class ShopErrorSearch extends SearchState {}
