import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/bloc/shop/bloc/shop_bloc.dart';
import 'package:softagi/layout/page_order.dart';
import 'package:softagi/modules/categories/categories_screen.dart';
import 'package:softagi/modules/favorite/favorite_screen.dart';
import 'package:softagi/modules/login_page.dart';
import 'package:softagi/modules/products/products_screen.dart';
import 'package:softagi/modules/search/search_screen.dart';
import 'package:softagi/modules/settings/settings_screen.dart';
import 'package:softagi/shared/components/components.dart';
import 'package:softagi/shared/components/network/cache.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Widget> screens = [
    ProductsPage(),
    CategoriesPage(),
    FavoritePage(),
    SettingPage()
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopBloc, ShopState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, widget: SearchPage());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ))
            ],
            title: Text(
              'Soukana',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          body: screens[currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            items: [
              Icon(
                Icons.home,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.apps,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.favorite,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.settings,
                size: 20,
                color: Colors.white,
              ),
            ],
            color: Colors.deepOrange,
            buttonBackgroundColor: Colors.deepOrange,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        );
      },
    );
    // bottomNavigationBar: BottomNavigationBar(
    //   currentIndex: currentIndex,
    //   onTap: (index) {
    //     setState(() {
    //       currentIndex = index;
    //     });
    //   },
    //   items: [
    //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    //     BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    //     BottomNavigationBarItem(
    //         icon: Icon(Icons.favorite), label: 'Favorites'),
    //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
    //   ],
    // ),
  }
}
