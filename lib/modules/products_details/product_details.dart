import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';

import 'package:softagi/modules/products_details/cubit/details_cubit.dart';

class ProductDetails extends StatefulWidget {
  dynamic id;
  ProductDetails({required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailsCubit()..getData(widget.id!),
        child: BlocConsumer<DetailsCubit, DetailsState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            // DetailsCubit.get(context).getData(id!);
            return Scaffold(
              appBar: AppBar(),
              body: BuildCondition(
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
                condition: state is ShopSuccessDetailsState,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          items: DetailsCubit.get(context)
                              .model!
                              .data!
                              .images!
                              .map(
                                (e) => CachedNetworkImage(
                                  // fit: BoxFit.cover,
                                  width: double.infinity,
                                  imageUrl: "${e}",
                                  placeholder: (context, url) => Image(
                                      image: AssetImage(
                                          'assets/images/MEBIB.gif')),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.35,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.easeInOutQuint,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${DetailsCubit.get(context).model!.data!.name}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              'Price: ',
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 20),
                            ),
                            Text(
                              '${DetailsCubit.get(context).model!.data!.price!.round().toString()}',
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 20),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  HomeCubit.get(context)
                                      .changeFavourite(widget.id);
                                });
                              },
                              icon:
                                  HomeCubit.get(context).isFavourite[widget.id]
                                      ? Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    HomeCubit.get(context)
                                        .changeCart(widget.id);
                                  });
                                },
                                child: HomeCubit.get(context).isCart[widget.id]!
                                    ? Text('Remove From Cart ')
                                    : Row(
                                        children: [
                                          Text('Add To Cart'),
                                          Icon(Icons.shopping_cart)
                                        ],
                                      ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.deepOrange),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  'Details',
                                  style: TextStyle(
                                      color: Colors.deepOrange, fontSize: 20),
                                ),
                                Text(
                                  '${DetailsCubit.get(context).model!.data!.description}',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
 //  CachedNetworkImage(
                  //   // fit: BoxFit.cover,
                  //   width: double.infinity,
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  //   imageUrl: "${DetailsCubit.get(context).model!.data!.image}",
                  //   placeholder: (context, url) =>
                  //       Image(image: AssetImage('assets/images/MEBIB.gif')),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),