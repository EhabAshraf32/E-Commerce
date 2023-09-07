// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_string_interpolations, non_constant_identifier_names, sort_child_properties_last

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/Widgets.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'package:shopapp/model/HomeLayoutModel.dart';
import '../model/CategoriesModel.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomLayoutCubit, HomLayoutState>(
      listener: (context, state) {
        if (state is ShopChangeFavouritesSuccessState) {
          if (state.changeFavouritesModel?.status == false) {
            snackbar(
                type: "Error",
                message: state.changeFavouritesModel!.message,
                color: HexColor("#990000"));
          }
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 6,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
                condition: HomLayoutCubit.get(context).homedata != null &&
                    HomLayoutCubit.get(context).categoriesData != null,
                builder: (context) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: productsBuilder(
                          homeModel: HomLayoutCubit.get(context).homedata,
                          categoriesModel:
                              HomLayoutCubit.get(context).categoriesData,
                          context: context),
                    ),
                fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    )),
          ),
        );
      },
    );
  }

  Widget productsBuilder({
    required HomeModel? homeModel,
    required CategoriesModel? categoriesModel,
    required BuildContext context,
  }) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 20,
                    child: Image.asset("assets/Logo.png")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Search(context),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          BanersShowDisplay(context, homeModel),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 20,
            width: double.infinity,
            child: buildCategories(context: context, model: categoriesModel),
          ),
          Container(
            height: 2000,
            child:
                TabBarView(physics: NeverScrollableScrollPhysics(), children: [
              ProductTabBarView(homeModel),
              ProductTabBarView(homeModel),
              ProductTabBarView(homeModel),
              ProductTabBarView(homeModel),
              ProductTabBarView(homeModel),
              ProductTabBarView(homeModel),
            ]),
          ),
        ],
      ),
    );
  }
}
