// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/constants/colors.dart';
import 'package:shopapp/helper/local/sharedPref.dart';
import 'package:shopapp/view/Login.dart';
import 'package:shopapp/view/ProductDetails.dart';
import 'package:shopapp/view/search.dart';

import 'controller/Login/login_cubit.dart';
import 'controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'model/CategoriesModel.dart';
import 'model/GetFavourites.dart';
import 'model/HomeLayoutModel.dart';

SnackbarController snackbar(
        {required String type,
        required String message,
        required HexColor color}) =>
    Get.snackbar(
      "$type",
      "$message",
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
    );

Widget CustomButton({
  LoginCubit? cubit,
  String text = "Sign in",
  required Function() OnPressed,
  required BuildContext context,
}) {
  return Container(
    height: MediaQuery.of(context).size.height / 14,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
        ),
        onPressed: OnPressed,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        )),
  );
}

void SignOut() {
  SharedPref.removeData(key: "token").then((value) => Get.offAll(Login()));
}

Widget Search(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Get.to(SearchScreen());
    },
    child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 200),
        decoration: BoxDecoration(
            color: HexColor("#F1F1F1"),
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 13.5,
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.height / 55),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey.shade500,
                size: 26,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 30,
              ),
              Text(
                "Search",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade500),
              )
            ],
          ),
        )),
  );
}

StaggeredGridView ProductTabBarView(HomeModel? homeModel) {
  return StaggeredGridView.countBuilder(
    itemCount: homeModel?.data.products.length,
    crossAxisCount: 4,
    shrinkWrap: true,
    //TODO:لما تشيل السطر الللي تحت د هيسكرول عادي
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) => buildGridProduct(
        model: HomLayoutCubit.get(context).homedata?.data.products[index],
        context: context),
    staggeredTileBuilder: (int index) => StaggeredTile.count(2, 2.8),
    mainAxisSpacing: 2,
    crossAxisSpacing: 2,
  );
}

Container BanersShowDisplay(BuildContext context, HomeModel? homeModel) {
  return Container(
    height: MediaQuery.of(context).size.height / 6,
    child: CarouselSlider(
        items: homeModel?.data.banners
            .map((e) => Image(
                  image: NetworkImage("${e.image}"),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ))
            .toList(),
        options: CarouselOptions(
          height: double.infinity,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        )),
  );
}

Widget buildGridProduct(
    {required ProductsDetails? model, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Get.to(ProductDetailsScreen(
        title: "${model.name}",
        image: "${model.image}",
        price: "${model.price}",
        old_pric: "${model.old_price}",
        discount: model.discount,
        discription: "${model.description}",
      ));
    },
    child: Container(
      // height: MediaQuery.of(context).size.height / 20,
      // width: MediaQuery.of(context).size.width / 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade400, width: 0.8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Image(
                      width: double.infinity,
                      image: NetworkImage(model!.image))),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 6),
                  ),
                )
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 2, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${model.price}",
                      style: TextStyle(fontSize: 10, color: Colors.blueAccent),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        "${model.old_price}",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {
                          HomLayoutCubit.get(context)
                              .changeFavourites(model.id);
                        },
                        icon: Icon(
                          HomLayoutCubit.get(context).favourites[model.id] ==
                                  false
                              ? Icons.favorite_outline
                              : Icons.favorite_outlined,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCategories(
    {required BuildContext context, required CategoriesModel? model}) {
  return TabBar(
      automaticIndicatorColorAdjustment: true,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      indicatorWeight: 2,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicator: BoxDecoration(
          color: primarycolor, borderRadius: BorderRadius.circular(20)),
      // ignore: prefer_const_literals_to_create_immutables
      tabs: [
        Tab(
          child: Text(
            "All",
          ),
        ),
        Tab(
          child: Text("${model?.data.data[0].name}"),
        ),
        Tab(
          child: Text("${model?.data.data[1].name}"),
        ),
        Tab(
          child: Text("${model?.data.data[2].name}"),
        ),
        Tab(
          child: Text("${model?.data.data[3].name}"),
        ),
        Tab(
          child: Text("${model?.data.data[4].name}"),
        ),
      ]);
}

Widget BuildListProduct(BuildContext context, model, {bool isOldPrice = true}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3.5,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(height: 180, width: 170, image: NetworkImage(model!.image)),
              if (model.discount != 0 && isOldPrice)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    "DISCOUNT",
                    style: TextStyle(color: Colors.white, fontSize: 6),
                  ),
                )
            ],
          ),
          Spacer(),
          Container(
            width: 200,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${model.price}",
                        style:
                            TextStyle(fontSize: 10, color: Colors.blueAccent),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          "${model.old_price}",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 18,
                          onPressed: () {
                            HomLayoutCubit.get(context)
                                .changeFavourites(model.id);
                          },
                          icon: HomLayoutCubit.get(context)
                                      .favourites[model.id] ==
                                  false
                              ? Icon(
                                  Icons.favorite_outline,
                                )
                              : Icon(
                                  Icons.favorite_outlined,
                                  color: primarycolor,
                                ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

inputTextField(
    {hintText,
    labeltext,
    obscuretext,
    controller,
    IconButton? icon,
    validator,
    required TextInputType keyboartype}) {
  return TextFormField(
    validator: validator,
    obscureText: obscuretext,
    controller: controller,
    decoration: InputDecoration(
        suffixIcon: icon,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primarycolor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        hintText: hintText,
        labelText: labeltext,
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(
          color: Colors.black38,
        )),
  );
}

Widget topheader(context, text, {required String image}) {
  return Padding(
    padding: EdgeInsets.only(
      left: MediaQuery.of(context).size.width / 20,
      top: MediaQuery.of(context).size.width / 10,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        Image.asset(
          '${image}',
          height: MediaQuery.of(context).size.height / 5.7,
          fit: BoxFit.fitHeight,
        )
      ],
    ),
  );
}
