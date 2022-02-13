import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/models/home_model.dart';
import 'package:softagi/models/search_model.dart';
import 'package:softagi/modules/products_details/product_details.dart';
// import 'package:softagi/modules/products/cubit/home_cubit.dart';
import 'package:softagi/modules/search/cubit/search_cubit.dart';
import 'package:softagi/shared/components/components.dart';

class SearchPage extends StatelessWidget {
  // SearchPage({Key? key}) : super(key: key);
  TextEditingController? searchController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is ShopSuccessSearch) {
            print(SearchCubit.get(context).search!.data!.data);
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: searchController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'please Enter Text to search ';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                        text: 'Search',
                        icon: Icon(Icons.search),
                        submit: (String text) {
                          formkey.currentState?.validate();
                          SearchCubit.get(context).searchProduct(text);
                          // SearchCubit.get(context)
                          //     .searchProduct(searchController!.text);
                        },
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     SearchCubit.get(context)
                      //         .searchProduct(searchController!.text);
                      //   },
                      //   icon: Icon(Icons.search),
                      // ),
                      SizedBox(height: 10),
                      if (state is ShopLoadingSearch) LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is ShopSuccessSearch)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return SearchBuild(
                                    model: SearchCubit.get(context)
                                        .search!
                                        .data!
                                        .data![index]);
                              },
                              separatorBuilder: (context, index) => Divider(),
                              itemCount: SearchCubit.get(context)
                                  .search!
                                  .data!
                                  .data!
                                  .length),
                        )
                      // if (state is ShopErrorSearch) Text('error')
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

class SearchBuild extends StatelessWidget {
  DBProducts? model;
  SearchBuild({this.model});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductDetails(
                      id: model!.id,
                    )));
          },
          child: Container(
            height: 120,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/MEBIB.gif'),
                    image: NetworkImage('${model!.image}'),
                  ),
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
                //   icon: true
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
          ),
        ));
  }
}
