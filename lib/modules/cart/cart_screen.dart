import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/models/cart_model.dart';
// import 'package:softagi/bloc/shop/bloc/favorites/bloc/favourites_bloc.dart';
import 'package:softagi/models/favourites_model.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      return BuildCondition(
        builder: (context) => Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                  'Cost is : ${HomeCubit.get(context).cartModel!.data!.subTotal}')),
          appBar: AppBar(
              // title: Center(
              //   child: Text(
              //     'Cost is : ${HomeCubit.get(context).cartModel!.data!.subTotal}',
              //     style: TextStyle(color: Colors.black),
              //   ),
              // ),
              ),
          body: ListView.separated(
              itemBuilder: (ctxt, index) {
                return CartBuild(
                    model: HomeCubit.get(context)
                        .cartModel!
                        .data!
                        .cartItems![index]);
              },
              separatorBuilder: (ctxt, index) => Divider(),
              itemCount:
                  HomeCubit.get(context).cartModel!.data!.cartItems!.length),
        ),
        condition: state is! ShopLoadingGetCarts,
        fallback: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

class CartBuild extends StatelessWidget {
  CartItems? model;
  CartBuild({this.model});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: "${model!.product!.image}",
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
                    HomeCubit.get(context).changeCart(model!.product!.id);
                  },
                  icon: HomeCubit.get(context).isCart[model!.product!.id]!
                      ? Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Price :',
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                Text('${model!.product!.price}')
              ],
            )
          ],
        ));
  }
}
