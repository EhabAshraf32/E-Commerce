// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/helper/DioHelper.dart';
import 'package:shopapp/helper/endPoints.dart';
import 'package:shopapp/model/LoginModel.dart';

import '../../helper/httpHelper.dart';
import 'Register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late Loginmodel loginmodel;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  bool changeicon = false;
  void changeIcon() {
    changeicon = !changeicon;
    emit(changeIconState());
  }

  void UserRegister() {
    emit(LoadingRegisterstate());
    DioHelper().postData(url: REGISTER, data: {
      "name": nameController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {
      loginmodel = Loginmodel.fromMap(value.data);
      //print(RegisterData.data?.email);
      emit(SuccsesfullRegisterState(Registerdata: loginmodel));
    }).catchError((error) {
      print(error);
      emit(ErrorRegisterState(error: error.toString()));
    });
  }
}
