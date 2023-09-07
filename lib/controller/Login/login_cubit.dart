// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/helper/DioHelper.dart';
import 'package:shopapp/helper/endPoints.dart';
import 'package:shopapp/model/LoginModel.dart';

import '../../model/changePasswordModel.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  late Loginmodel LoginData;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool changeicon = false;
  void changeIcon() {
    changeicon = !changeicon;
    emit(changeIconState());
  }

  void UserLogin() {
    emit(Loadingstate());
    DioHelper().postData(url: LOGIN, data: {
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {
      LoginData = Loginmodel.fromMap(value.data);
      //print(LoginData.data?.email);
      emit(SuccsesfullLoginState(logindata: LoginData));
    }).catchError((error) {
      print(error);
      emit(ErrorLoginState(error: error.toString()));
    });
  }

  late ChangePasswordclass modell;

  void ChangePassowrd(
      {required String old_password, required String new_password}) {
    emit(ChangePasswordLoadingState());
    DioHelper().postData(url: CHANGEPASSWORD, token: token, data: {
      "current_password": old_password,
      "new_password": new_password
    }).then((value) {
      modell = ChangePasswordclass.fromMap(value.data);
      print(modell.message);
      //print(LoginData.data?.email);
      emit(ChangePasswordSucessfullState(model: modell));
    }).catchError((error) {
      print("the error is${error} ");
      print("the error isssss${modell.message} ");
      emit(ChangePasswordErrorState(error: error.toString()));
    });
  }
}
