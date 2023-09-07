import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, prefer_is_empty, avoid_print, unnecessary_string_interpolations, use_key_in_widget_constructors, must_be_immutable, unused_local_variable
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/constants/colors.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controller/Login/login_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapp/controller/Register/Register_cubit.dart';
import 'package:shopapp/controller/Register/Register_state.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/view/Login.dart';

import '../Widgets.dart';
import '../helper/local/sharedPref.dart';

class Register extends StatelessWidget {
  @override
  var formstate = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          var cubit = RegisterCubit.get(context);
          if (state is SuccsesfullRegisterState) {
            if (state.Registerdata.status) {
              SharedPref.setData(
                      key: "token", value: state.Registerdata.data?.token)
                  .then((value) {
                var model = RegisterCubit.get(context).loginmodel;
                final token2 = model.data?.token ?? " ";
                token = token2;
                Get.off(Login());
              });
              snackbar(
                  type: "Success",
                  message: "${cubit.loginmodel.message}",
                  color: HexColor("#1B5E20"));
            } else {
              print(state.Registerdata.message);
              snackbar(
                  type: "Error",
                  message: "${cubit.loginmodel.message}",
                  color: HexColor("#990000"));
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Scaffold(
                backgroundColor: primarycolor,
                body: Form(
                  key: formstate,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topheader(
                          context, 'Sign Up Now\nTo Communicate\nWith Friends',
                          image: "assets/img_register.png"),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          color: Colors.grey[50],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: primarycolor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              inputTextField(
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "the field must not be empty";
                                    }
                                    if (text.length < 6) {
                                      return "Name can not be Less than 6 Letter";
                                    }

                                    return null;
                                  },
                                  keyboartype: TextInputType.name,
                                  hintText: 'Enter your username',
                                  labeltext: "User Name",
                                  obscuretext: false,
                                  controller: RegisterCubit.get(context)
                                      .nameController),
                              SizedBox(height: 16),
                              inputTextField(
                                  validator: (text) {
                                    if (text.length == 0 ||
                                        !text.contains("@")) {
                                      return "please enter valid email address @example.com";
                                    }
                                    if (text.length < 6) {
                                      return "Email can not be Less than 6 Letter";
                                    }
                                    if (text.isEmpty) {
                                      return "The field can not be empty";
                                    }

                                    return null;
                                  },
                                  keyboartype: TextInputType.emailAddress,
                                  hintText: 'example@email.com',
                                  labeltext: "Email",
                                  obscuretext: false,
                                  controller: RegisterCubit.get(context)
                                      .emailController),
                              SizedBox(height: 16),
                              inputTextField(
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "Password can not be Empty";
                                    }
                                    if (text.length < 6) {
                                      return "Password can not be Less than 6 Letter";
                                    }

                                    return null;
                                  },
                                  keyboartype: TextInputType.visiblePassword,
                                  hintText: '******',
                                  labeltext: "Password",
                                  obscuretext:
                                      RegisterCubit.get(context).changeicon
                                          ? false
                                          : true,
                                  icon: IconButton(
                                      onPressed: () {
                                        RegisterCubit.get(context).changeIcon();
                                      },
                                      icon:
                                          RegisterCubit.get(context).changeicon
                                              ? Icon(
                                                  Icons.visibility,
                                                  color: primarycolor,
                                                )
                                              : Icon(
                                                  Icons.visibility_off,
                                                  color: Color(0xFF979797),
                                                )),
                                  controller: RegisterCubit.get(context)
                                      .passwordController),
                              SizedBox(height: 16),
                              inputTextField(
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "the field must not be empty";
                                    }
                                    if (text.length < 6) {
                                      return "Phone can not be Less than 11 number";
                                    }

                                    return null;
                                  },
                                  keyboartype: TextInputType.phone,
                                  hintText: 'Your phone number',
                                  labeltext: "Phone",
                                  obscuretext: false,
                                  controller: RegisterCubit.get(context)
                                      .phoneController),
                              SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    //TODO
                                  },
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      color: primarycolor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ConditionalBuilder(
                                condition: state is! LoadingRegisterstate,
                                builder: (context) => GestureDetector(
                                  onTap: () {
                                    if (formstate.currentState!.validate()) {
                                      cubit.UserRegister();
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: primarycolor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                                fallback: (context) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account ?",
                                      style: TextStyle(color: Colors.black54)),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(Login());
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(color: primarycolor),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
