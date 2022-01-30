import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/login_bloc.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/models/category.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return BuildCondition(
          condition: state is ShopSuccessHomePage ||
              state is ChangeFavoritesSuccessState ||
              state is GetProfileState,
          builder: (context) => state is ShopSuccessHomePage ||
                  state is GetProfileState ||
                  state is ChangeFavoritesSuccessState
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${state.categories?.data!.data![index].image}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${state.categories?.data!.data![index].name}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: state.categories!.data!.data!.length,
                )
              : Text('Null'),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          ),
        );
      },
    );
  }
}

class buildCategory extends StatelessWidget {
  buildCategory({
    Key? key,
    DataModel? category,
    // CategoriesModel? cat,
  }) : super(key: key);
  DataModel? category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            image: NetworkImage('${category!.image}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${category!.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
