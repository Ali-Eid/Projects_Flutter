import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:softagi/bloc/login_bloc.dart';
// import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/models/category.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return buildCategory(
                category: HomeCubit.get(context).category!.data!.data![index]);
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          physics: BouncingScrollPhysics(),
          itemCount: HomeCubit.get(context).category!.data!.data!.length,
        );
      },
    );
  }
}

class buildCategory extends StatelessWidget {
  DataModel? category;
  buildCategory({this.category});
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
