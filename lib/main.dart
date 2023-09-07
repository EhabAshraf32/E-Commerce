// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable, prefer_const_constructors_in_immutables, must_be_immutable, unnecessary_null_comparison, avoid_print
// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'package:shopapp/helper/local/sharedPref.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/view/Login.dart';
import 'package:shopapp/view/OnBoarding.dart';

import 'BlocObserve.dart';
import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  bool OnBoard = SharedPref.getData(key: "OnBoarding");
  token = SharedPref.getData(key: "token");
  Bloc.observer = MyBlocObserver();

  print(token);
  Widget wedget;

  if (OnBoard != null) {
    if (token != null) {
      wedget = ShopLayout();
    } else {
      wedget = Login();
    }
  } else {
    wedget = OnBoarding();
  }

  runApp(MyApp(wedget: wedget));
}

class MyApp extends StatelessWidget {
  final Widget wedget;
  MyApp({
    Key? key,
    required this.wedget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomLayoutCubit()
        ..getHomeData()
        ..getHomeCategories()
        ..getFavourites()
        ..getSeetings(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
              ),
            ),
            fontFamily: "family"),
        home: wedget,
      ),
    );
  }
}
