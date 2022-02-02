import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavourites) {
          if (!(state.fav!.status!)) {
            showToast(message: state.fav!.message, state: ToastState.error);
          }
          // showToast(message: state.fav!.message, state: ToastState.warning);
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: HomeCubit.get(context).homeModel != null &&
              HomeCubit.get(context).category != null,
          builder: (context) =>
              // state is ShopSuccessHomePage ||
              // state is GetProfileState ||
              // state is ChangeFavoritesSuccessState
              HomePage(
            model: HomeCubit.get(context).homeModel,
            category: HomeCubit.get(context).category,
          ),
          // : Text('Null'),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  HomeModel? model;
  CategoriesModel? category;
  // Map<int?, bool?>? isFav = {};
  HomePage({this.model, this.category});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data!.banners!
                .map(
                  (e) =>
                      //  FadeInImage(
                      //   placeholder: AssetImage('assets/images/MEBIB.gif'),
                      //   image: NetworkImage('${e.image}'),
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageUrl: "${e.image}",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.25,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOutQuint,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          CategoryItem(category: category!.data!.data![index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10,
                          ),
                      itemCount: category!.data!.data!.length),
                ),
                Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            // color: Colors.grey[300],
            child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.6,
                crossAxisCount: 2,
                children:
                    List.generate(model!.data?.products?.length ?? 0, (index) {
                  return ProductWidget(
                    model: model!.data?.products?[index],
                    // isFav: {
                    //   model!.data!.products![index].id:
                    //       model!.data!.products![index].inFavorites
                    // },
                  );
                })),
          )
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  CategoryItem({Key? key, this.category}) : super(key: key);
  DataModel? category;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // Image(
          //   image: NetworkImage('${category!.image}'),
          //   height: 100,
          //   width: 100,
          //   fit: BoxFit.cover,
          // ),
          // FadeInImage(
          //   placeholder: AssetImage('assets/images/MEBIB.gif'),
          //   image: NetworkImage('${category!.image}'),
          //   height: 100,
          //   width: 100,
          //   fit: BoxFit.cover,
          // ),
          CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl: "'${category!.image}'",
            placeholder: (context, url) =>
                Image(image: AssetImage('assets/images/MEBIB.gif')),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              '${category!.name}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductWidget extends StatelessWidget {
  ProductWidget({
    Key? key,
    required this.model,
    this.isFav,
  }) : super(key: key);
  Map<int?, bool?>? isFav = {};
  Products? model;
  @override
  Widget build(BuildContext context) {
    return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // FadeInImage(
              //   placeholder: AssetImage('assets/images/MEBIB.gif'),
              //   image: NetworkImage('${model!.image}'),
              //   //: AssetImage('assets/images/MEBIB.gif'),
              //   width: double.infinity,
              //   height: 120,
              // ),
              CachedNetworkImage(
                width: double.infinity,
                height: 120,
                imageUrl: "${model!.image}",
                placeholder: (context, url) =>
                    Image(image: AssetImage('assets/images/MEBIB.gif')),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              if (model!.price != model!.oldPrice)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.deepOrange,
                  child: Text(
                    'Discount',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )
            ],
          ),
          Text(
            '${model!.name!}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                '${model!.price.round()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.deepOrange),
              ),
              SizedBox(
                width: 8,
              ),
              if (model!.price != model!.oldPrice)
                Text(
                  '${model!.oldPrice.round()}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  HomeCubit.get(context).changeFavourite(model!.id);
                },
                icon: HomeCubit.get(context).isFavourite[model!.id]
                    ? Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
              )
            ],
          ),
        ]);
  }
}
// BuildCondition(
//                     builder: (context) => Icon(
//                       Icons.favorite_outlined,
//                       color: Colors.red,
//                     ),
//                     condition: BlocProvider.of<FavouritesBloc>(context)
//                         .isFavorites[model!.id],
//                     fallback: (context) => Icon(
//                       Icons.favorite_border,
//                       color: Colors.red,
//                     ),
//                   )