// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shopapp/constants/colors.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomLayoutCubit, HomLayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: SalomonBottomBar(
              itemPadding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              curve: Curves.easeInOutQuart,
              currentIndex: HomLayoutCubit.get(context).selectedindex,
              onTap: (index) {
                HomLayoutCubit.get(context).ChangeIndex(index);
              },
              items: [
                SalomonBottomBarItem(
                    unselectedColor: Colors.grey,
                    selectedColor: primarycolor,
                    icon: Icon(Icons.home),
                    title: Text(
                      "Home",
                    )),
                SalomonBottomBarItem(
                    selectedColor: primarycolor,
                    unselectedColor: Colors.grey,
                    icon: Icon(Icons.category),
                    title: Text("Categories")),
                SalomonBottomBarItem(
                    selectedColor: primarycolor,
                    unselectedColor: Colors.grey,
                    icon: Icon(Icons.favorite_outlined),
                    title: Text("Favourites")),
                SalomonBottomBarItem(
                    selectedColor: primarycolor,
                    unselectedColor: Colors.grey,
                    icon: Icon(Icons.settings),
                    title: Text("Settings"))
              ]),
          body: HomLayoutCubit.get(context)
              .pages[HomLayoutCubit.get(context).selectedindex],
        );
      },
    );
  }
}
