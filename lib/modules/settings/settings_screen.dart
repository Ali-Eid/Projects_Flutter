import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/modules/login_page.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/network/cache.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        BlocProvider.of<ShopBloc>(context).add(GetProfileEvent());
        return BuildCondition(
          builder: (context) => state is GetProfileState
              ? Padding(
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
                          child: Image(
                            image: NetworkImage('${state.model!.data!.image}'),
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${state.model!.data!.name}',
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${state.model!.data!.email}',
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${state.model!.data!.phone}',
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
                                    MaterialPageRoute(
                                        builder: (_) => LoginPage()),
                                    (route) => false);
                              }),
                        ],
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          condition: BlocProvider.of<ShopBloc>(context).loginModel != null,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
