// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print, avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/helper/endPoints.dart';
import 'package:shopapp/model/CategoriesModel.dart';
import 'package:shopapp/model/ChangeFavourites.dart';
import 'package:shopapp/model/GetFavourites.dart';
import 'package:shopapp/model/HomeLayoutModel.dart';
import 'package:shopapp/model/LoginModel.dart';
import 'package:shopapp/view/categories.dart';
import 'package:shopapp/view/favourites.dart';
import 'package:shopapp/view/products.dart';
import 'package:shopapp/view/settings.dart';

import '../../../helper/DioHelper.dart';

part 'hom_layout_state.dart';

class HomLayoutCubit extends Cubit<HomLayoutState> {
  HomLayoutCubit() : super(HomLayoutInitial());
  static HomLayoutCubit get(context) => BlocProvider.of(context);

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  Loginmodel? settingsModels;
  int selectedindex = 0;

  List<Widget> pages = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen()
  ];

  void ChangeIndex(index) {
    selectedindex = index;
    emit(BottomNaviState());
  }

//GET PRODUCTS DATA
  HomeModel? homedata;
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper().getData(url: HOME, token: token).then((value) {
      homedata = HomeModel.fromMap(value.data);
      print(homedata!.data.banners[1].image);

      homedata!.data.products.forEach((element) {
        favourites.addAll({element.id: element.in_favorites});
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSuccessHomeDataState());
    });
  }

//GET CATEGORIES DATA
  CategoriesModel? categoriesData;
  void getHomeCategories() {
    emit(ShopLoadingHomeDataState());
    DioHelper().getData(url: GET_CATEGORIES).then((value) {
      categoriesData = CategoriesModel.fromMap(value.data);
      print(categoriesData?.data.data[0].image);
      emit(ShopCategoriesSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorHomeDataState());
    });
  }

  ChangeFavourites? changeFavouritesModel;
  void changeFavourites(int product_id) {
    //TODO ديemitمتنساش تشيل ال
    // emit(ShopFavouritesSuccessState());
    favourites[product_id] = !favourites[product_id]!;
    emit(ShopFavouritesSuccessState());
    DioHelper()
        .postData(
            url: FAVORITES, data: {"product_id": product_id}, token: token)
        .then((value) {
      changeFavouritesModel = ChangeFavourites.fromMap(value.data);

      if (changeFavouritesModel?.status == false) {
        favourites[product_id] = !favourites[product_id]!;
      } else {
        getFavourites();
      }
      emit(ShopChangeFavouritesSuccessState(changeFavouritesModel));
    }).catchError((error) {
      favourites[product_id] = !favourites[product_id]!;
      emit(ShopChangeFavouritesErrorState());
    });
  }

  GetFavourites? GetFavouritesModel;
  void getFavourites() {
    emit(ShopLoadingFavouritesState());
    DioHelper().getData(url: FAVORITES, token: token).then((value) {
      GetFavouritesModel = GetFavourites.fromMap(value.data);
      emit(ShopGetFavouritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavouritesErrorState());
    });
  }

  void getSeetings() {
    emit(ShopLoadingSettingsState());
    DioHelper().getData(url: PROFILE, token: token).then((value) {
      settingsModels = Loginmodel.fromMap(value.data);
      emit(ShopGetSettingsSuccessState(settingsModel: settingsModels!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetSettingsErrorState());
    });
  }

  void updateUserData() {
    emit(ShopLoadingUpdateState());
    DioHelper().putData(url: UPDATE_PROFILE, token: token, data: {
      "name": namecontroller.text,
      "phone": phonecontroller.text,
      "email": emailcontroller.text,
      // "password": password
    }).then((value) {
      // Update the settingsModels with the new data
      settingsModels = Loginmodel.fromMap(value.data);

      // Update the text controllers with the new data
      namecontroller.text = settingsModels?.data?.name ?? '';
      emailcontroller.text = settingsModels?.data?.email ?? '';
      phonecontroller.text = settingsModels?.data?.phone ?? '';
      print(value.data);
      emit(ShopGetUpdateSuccessState());
    }).catchError((error) {
      print(error);
      emit(ShopGetUpdateErrorState());
    });
  }
}
