import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/models/categories_details.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';
import 'package:softagi/modules/products_details/product_details.dart';
// import 'package:softagi/modules/products_details/cubit/details_cubit.dart';

class CategoriesDetails extends StatelessWidget {
  int? id;
  CategoriesDetails({this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: BuildCondition(
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
            condition: state is! ShopLoadingDetailsCategory,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) {
                  return CategoriesBuild(
                      model: HomeCubit.get(context)
                          .modelCategory!
                          .data!
                          .data![index]);
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount:
                    HomeCubit.get(context).modelCategory!.data!.data!.length),
          ),
        );
      },
    );
  }
}

class CategoriesBuild extends StatelessWidget {
  DataModel? model;
  CategoriesBuild({this.model});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetails(
                  id: model!.id,
                )));
      },
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 120,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: "${model!.image}",
                    placeholder: (context, url) =>
                        Image(image: AssetImage('assets/images/MEBIB.gif')),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  //  FadeInImage(
                  //   placeholder: AssetImage('assets/images/MEBIB.gif'),
                  //   image: NetworkImage('${model!.product!.image}'),
                  // ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${model!.name}',
                      style: TextStyle(
                        fontSize: 14,
                        //   fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Spacer(),
                // IconButton(
                //   onPressed: () {
                //     HomeCubit.get(context).changeFavourite(model!.product!.id);
                //   },
                //   icon: HomeCubit.get(context).isFavourite[model!.product!.id]
                //       ? Icon(
                //           Icons.favorite_outlined,
                //           color: Colors.red,
                //         )
                //       : Icon(
                //           Icons.favorite_border,
                //           color: Colors.red,
                //         ),
                // )
              ],
            ),
          )),
    );
  }
}
