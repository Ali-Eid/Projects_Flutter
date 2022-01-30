import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/shop/bloc/favorites/bloc/favourites_bloc.dart';
import 'package:softagi/models/favourites_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesBloc()..add(FavouritesGetEvent()),
      child: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BuildCondition(
              condition:
                  BlocProvider.of<FavouritesBloc>(context).favouritesGET !=
                      null,
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
              builder: (context) => BlocProvider.of<FavouritesBloc>(context)
                          .Favourites!
                          .data!
                          .total !=
                      0
                  ? state is GetFavoritesSuccessState1
                      // state is DeleteFavoritesState
                      // state is DeleteFavoritesState
                      ? ListView.separated(
                          itemBuilder: (ctxt, index) {
                            return FavouritesBuild(
                              model: state.model!.data!.data![index],
                            );
                          },
                          separatorBuilder: (ctxt, index) => Divider(),
                          itemCount: state.model!.data!.data!.length)
                      : Center(
                          child: CircularProgressIndicator(),
                        )
                  : Center(
                      child: Text(
                        'No Favourites Item in List',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ));
        },
      ),
    );
  }
}

class FavouritesBuild extends StatelessWidget {
  ProductData? model;
  FavouritesBuild({this.model});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                child: FadeInImage(
                  placeholder: AssetImage('assets/images/MEBIB.gif'),
                  image: NetworkImage('${model!.product!.image}'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '${model!.product!.name}',
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
              IconButton(
                onPressed: () {
                  BlocProvider.of<FavouritesBloc>(context)
                      .add(FavouritesDeleteEvent(id: model!.id));
                  BlocProvider.of<FavouritesBloc>(context)
                      .add(FavouritesGetEvent());
                },
                icon: Icon(Icons.favorite_rounded, color: Colors.deepOrange),
              )
            ],
          ),
        ));
    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Column(
    //       // mainAxisAlignment: MainAxisAlignment.start,
    //       // crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Stack(
    //           alignment: Alignment.bottomLeft,
    //           children: [
    //             Image(
    //               image: NetworkImage(
    //                   '${'https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg'}'),

    //               width: double.infinity,
    //               height: 120,
    //               //            fit: BoxFit.cover,
    //             ),
    //             if (model!.product!.price != model!.product!.oldPrice)
    //               Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 8),
    //                 color: Colors.deepOrange,
    //                 child: Text(
    //                   'Discount',
    //                   style: TextStyle(fontSize: 12, color: Colors.white),
    //                 ),
    //               )
    //           ],
    //         ),
    //         Text(
    //           '${model!.product!.name}',
    //           maxLines: 2,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //         Row(
    //           children: [
    //             Text(
    //               '${model!.product!.price.round()}',
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(color: Colors.deepOrange),
    //             ),
    //             SizedBox(
    //               width: 8,
    //             ),
    //             if (model!.product!.price != model!.product!.oldPrice)
    //               Text(
    //                 '${model!.product!.oldPrice}',
    //                 style: TextStyle(
    //                   color: Colors.grey,
    //                   fontSize: 14,
    //                   decoration: TextDecoration.lineThrough,
    //                 ),
    //               ),
    //             Spacer(),
    //             IconButton(
    //               onPressed: () {
    //                 BlocProvider.of<FavouritesBloc>(context)
    //                     .add(FavouritesGetEvent());
    //                 // setState(() {
    //                 //   BlocProvider.of<ShopBloc>(context)
    //                 //       .add(GetFavoritesEvent(id: widget.model!.id));
    //                 // });
    //               },
    //               icon: true
    //                   //  BlocProvider.of<FavouritesBloc>(context)
    //                   //         .isFavorites![model!.id]
    //                   ? Icon(
    //                       Icons.favorite_outlined,
    //                       color: Colors.red,
    //                     )
    //                   : Icon(
    //                       Icons.favorite_border,
    //                       color: Colors.red,
    //                     ),
    //             )
    //           ],
    //         ),
    //       ]),
  }
}
