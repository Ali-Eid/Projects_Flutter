import 'package:buildcondition/buildcondition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/models/login_model.dart';
// import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/modules/login/login_page.dart';
import 'package:softagi/modules/products/cubit/home_cubit.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/network/cache.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        // state is ShopSuccessGetProfile;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.35,
                width: MediaQuery.of(context).size.width * 0.35,
                child: CircleAvatar(
                  radius: 30,
                  child: CachedNetworkImage(
                    imageUrl:
                        "${HomeCubit.get(context).userModel!.data!.image}",
                    placeholder: (context, url) =>
                        Image(image: AssetImage('assets/images/MEBIB.gif')),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Name :',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${HomeCubit.get(context).userModel!.data!.name}',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email :',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${HomeCubit.get(context).userModel!.data!.email}',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Phone :',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${HomeCubit.get(context).userModel!.data!.phone}',
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  defaultElevatedButton(
                      child: Text('Logout'),
                      onPressed: () {
                        CacheHelper.removeData(key: 'token');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => LoginPage()),
                            (route) => false);
                      }),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

// class buildProfile extends StatelessWidget {
//   Data? model;
//   buildProfile({this.model});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.width * 0.35,
//             width: MediaQuery.of(context).size.width * 0.35,
//             child: CircleAvatar(
//               radius: 30,
//               child: Image(
//                 image: NetworkImage('${model!.image}'),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Name :',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${model!.name}',
//                     style: TextStyle(
//                         color: Colors.deepOrange, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Email :',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${model!.email}',
//                     style: TextStyle(
//                         color: Colors.deepOrange, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Phone :',
//                     style: TextStyle(
//                         color: Colors.black, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${model!.phone}',
//                     style: TextStyle(
//                         color: Colors.deepOrange, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               defaultElevatedButton(
//                   child: Text('Logout'),
//                   onPressed: () {
//                     CacheHelper.removeData(key: 'token');
//                     Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(builder: (_) => LoginPage()),
//                         (route) => false);
//                   }),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
