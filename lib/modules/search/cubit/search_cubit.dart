import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/search_model.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/constants.dart';
// import 'package:softagi/shared/constants.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? search;

  void searchProduct(String text) {
    emit(ShopLoadingSearch());
    DioHelper.postData(url: GET_SEARCH, data: {'text': text}, token: token)
        .then((value) {
      search = SearchModel.fromJson(value.data);
      print(search!.data!.data);
      emit(ShopSuccessSearch());
    }).catchError((error) {
      emit(ShopErrorSearch());
    });
  }
}
