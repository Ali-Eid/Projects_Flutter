part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class ShopLoadingDetailsState extends DetailsState {}

class ShopSuccessDetailsState extends DetailsState {
  // HomeModel? search;
  // ShopSuccessSearch({this.search});
}

class ShopErrorDetailsState extends DetailsState {}

class ShopLoadingDetailsCategory extends DetailsState {}

class ShopSuccessDetailsCategory extends DetailsState {
  // HomeModel? search;
  // ShopSuccessSearch({this.search});
}

class ShopErrorDetailsCategory extends DetailsState {}
