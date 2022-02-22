import 'package:buildcondition/buildcondition.dart';
import 'package:dardesh/layout/cubit/home_cubit.dart';
import 'package:dardesh/module/Login/login_screen.dart';
import 'package:dardesh/module/posts/posts_screen.dart';
import 'package:dardesh/shared/cach_helper.dart';
import 'package:dardesh/shared/components/components.dart';
import 'package:dardesh/shared/constants.dart';
import 'package:dardesh/shared/style/icon_broken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Switch(
                      value: mode,
                      onChanged: (value) {
                        HomeCubit.get(context).changeMode(value);
                      }),
                  TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        CacheHelper.removeData(key: 'token').then((value) {
                          print('${CacheHelper.getData(key: 'token')}');
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginPage()),
                              (route) => false);
                        });
                      },
                      child: Text('Logout'))
                ],
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              // elevation: 20,
              clipBehavior: Clip.antiAliasWithSaveLayer,

              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PostsScreen()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    IconBroken.Paper_Upload,
                    color: Colors.white,
                  ),
                  Text(
                    'post',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(IconBroken.Notification)),
                IconButton(onPressed: () {}, icon: Icon(IconBroken.Search))
              ],
              title: Text(
                '${cubit.appBarTitle[cubit.currentindex]}',
                // style: Theme.of(context).textTheme.bodyText1!.copyWith(
                //     fontFamily: 'Jannah',
                //     // color: Colors.purple,
                //     fontWeight: FontWeight.bold),
              ),
            ),
            body: cubit.screens[cubit.currentindex],
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: CircularNotchedRectangle(),
              notchMargin: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: buildTabItem(
                      context: context,
                      index: 0,
                      icon: Icon(IconBroken.Home),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: buildTabItem(
                      context: context,
                      index: 1,
                      icon: Icon(IconBroken.Chat),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: buildTabItem(
                      context: context,
                      index: 2,
                      icon: Icon(IconBroken.User),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: buildTabItem(
                      context: context,
                      index: 3,
                      icon: Icon(IconBroken.Setting),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget buildTabItem({
    required context,
    required int index,
    required Icon icon,
  }) {
    return IconButton(
      onPressed: () {
        HomeCubit.get(context).changeBotomNav(index);
      },
      icon: icon,
      color: HomeCubit.get(context).currentindex == index
          ? Colors.purple
          : Colors.purple.withOpacity(0.60),
    );
  }
}
// Column(
//                     children: [
//                       if (!(FirebaseAuth.instance.currentUser!.emailVerified))
//                         Container(
//                           // height: 50,
//                           color: Colors.amber.withOpacity(0.6),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.info_outline),
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 Expanded(
//                                     child: Text('Please verify your Email...')),
//                                 // Spacer(),
//                                 TextButton(
//                                     onPressed: () {
//                                       FirebaseAuth.instance.currentUser
//                                           ?.sendEmailVerification()
//                                           .then((value) {
//                                         showToast(
//                                             message: 'Check your mail',
//                                             state: ToastState.success);
//                                       }).catchError((error) {});
//                                     },
//                                     child: Text('Send'))
//                               ],
//                             ),
//                           ),
//                         ),
//                       Center(
//                         child: Text(
//                             '${FirebaseAuth.instance.currentUser!.emailVerified}'),
//                       )
//                     ],
//                   );

// BottomNavigationBar(

//             onTap: (index) {
//               cubit.changeBotomNav(index);
//             },
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(IconBroken.Home), label: 'Home'),
//               BottomNavigationBarItem(
//                   icon: Icon(IconBroken.Chat), label: 'Chat'),
//               BottomNavigationBarItem(
//                   icon: Icon(IconBroken.User), label: 'User'),
//               BottomNavigationBarItem(
//                   icon: Icon(IconBroken.Setting), label: 'Settings'),
//             ],
//             currentIndex: cubit.currentindex,
//           ),
