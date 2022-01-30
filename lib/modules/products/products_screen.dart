import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/end_points.dart';
import 'package:softagi/shared/components/network/Dio.dart';
import 'package:softagi/shared/components/network/cache.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopBloc()..add(GetDataHome()),
      child: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {
          // if (state is GetProfileState) {
          //   BlocProvider.of<ShopBloc>(context).add(GetDataHome());
          // }
          if (state is ChangeFavoritesSuccessState) {
            if (state.fav!.status!) {
              showToast(
                  message: '${state.fav!.message}', state: ToastState.error);
              state is ShopSuccessHomePage;
            }
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return BuildCondition(
            condition: BlocProvider.of<ShopBloc>(context).homeModel != null &&
                BlocProvider.of<ShopBloc>(context).categories != null,
            builder: (context) => state is ShopSuccessHomePage ||
                    state is GetProfileState ||
                    state is ChangeFavoritesSuccessState
                ? HomePage(
                    model: state.homeModel,
                    category: state.categories,
                  )
                : Text('Null'),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
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
                      // Image(
                      //       image: NetworkImage('${e.image}'),
                      //       width: double.infinity,
                      //       fit: BoxFit.cover,
                      //     )
                      FadeInImage(
                    placeholder: AssetImage('assets/images/MEBIB.gif'),
                    image: AssetImage('assets/images/MEBIB.gif'),
                    width: double.infinity,
                    fit: BoxFit.cover,
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
          FadeInImage(
            placeholder: AssetImage('assets/images/MEBIB.gif'),
            image: NetworkImage('${category!.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
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

class ProductWidget extends StatefulWidget {
  ProductWidget({
    Key? key,
    required this.model,
    this.isFav,
  }) : super(key: key);
  Map<int?, bool?>? isFav = {};
  final Products? model;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  Widget build(BuildContext context) {
    // print(BlocProvider.of<ShopBloc>(context).isFavorites);
    // CacheHelper.saveData(
    // key: 'image ${widget.model!.id}', value: '${widget.model!.image}');
    var imageCash = CacheHelper.getData(key: 'image ${widget.model!.id}');

    return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // Image(
              //   image: NetworkImage(widget.model!.image!),
              //   width: double.infinity,
              //   height: 200,
              //   //            fit: BoxFit.cover,
              // ),
              // Image(
              //   image: NetworkImage(
              //       '${imageCash}'),
              //   //: AssetImage('assets/images/MEBIB.gif'),
              //   width: double.infinity,
              //   height: 120,
              // ),
              FadeInImage(
                placeholder: AssetImage('assets/images/MEBIB.gif'),
                image: NetworkImage('${imageCash}'),
                //: AssetImage('assets/images/MEBIB.gif'),
                width: double.infinity,
                height: 120,
              ),
              if (widget.model!.price != widget.model!.oldPrice)
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
            '${widget.model!.name!}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Text(
                '${widget.model!.price.round()}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.deepOrange),
              ),
              SizedBox(
                width: 8,
              ),
              if (widget.model!.price != widget.model!.oldPrice)
                Text(
                  '${widget.model!.oldPrice.round()}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    // print(BlocProvider.of<ShopBloc>(context).isFavorites);
                    BlocProvider.of<ShopBloc>(context)
                        .add(ChangeFavoritesEvent(id: widget.model!.id));
                    //          print(BlocProvider.of<ShopBloc>(context).isFavorites);
                  });
                },
                icon: BlocProvider.of<ShopBloc>(context)
                        .isFavorites[widget.model!.id]
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