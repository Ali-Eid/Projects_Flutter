// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:softagi/models/categories_details.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/product_details.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/constants.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  static DetailsCubit get(context) => BlocProvider.of(context);

  ProductsDetails? model;
  void getData(dynamic id) {
    emit(ShopLoadingDetailsState());
    DioHelper.getData(url: 'products/${id}', token: token).then((value) {
      model = ProductsDetails.fromJson(value.data);
      print(model!.data!.id);
      emit(ShopSuccessDetailsState());
    }).catchError((error) {
      // print("progress Error");
      print(error.toString());
      emit(ShopErrorDetailsState());
    });
  }

  // CategoryDetails? modelCategory;
  // void getCategoriesData() {
  //   emit(ShopLoadingDetailsCategory());
  //   DioHelper.getData(
  //     url: 'products?category_id=44',
  //     // queryparameters: {'category_id': id},
  //     token: token,
  //   ).then((value) {
  //     modelCategory = CategoryDetails.fromJson(value.data);
  //     print(modelCategory);
  //     // print(modelCategory!.data!.data!.length);
  //     emit(ShopSuccessDetailsCategory());
  //   }).catchError((error) {
  //     // print("progress Error");
  //     emit(ShopErrorDetailsCategory());
  //   });
  // }
}
