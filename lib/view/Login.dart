// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names, prefer_is_empty, avoid_print, unnecessary_string_interpolations, use_key_in_widget_constructors, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/constants/colors.dart';
import 'package:shopapp/constants/constants.dart';
import 'package:shopapp/controller/Login/login_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:shopapp/layout/shopLayout.dart';
import '../Widgets.dart';
import '../helper/local/sharedPref.dart';
import 'Regeister.dart';

class Login extends StatelessWidget {
  @override
  var formstate = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          var cubit = LoginCubit.get(context);
          if (state is SuccsesfullLoginState) {
            if (state.logindata.status) {
              SharedPref.setData(
                      key: "token", value: state.logindata.data?.token)
                  .then((value) {
                var model = LoginCubit.get(context).LoginData;
                final token2 = model.data?.token ?? " ";
                token = token2;
                Get.offAll(ShopLayout());
              });
              print(state.logindata.message);
              print(state.logindata.data?.token);
              snackbar(
                  type: "Success",
                  message: "${cubit.LoginData.message}",
                  color: HexColor("#1B5E20"));
            } else {
              print(state.logindata.message);
              snackbar(
                  type: "Error",
                  message: "${cubit.LoginData.message}",
                  color: HexColor("#990000"));
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                      topheader(context, 'Login with\nYour\nAccount',
                          image: "assets/gbimage.png"),
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
                                "Sign In",
                                style: TextStyle(
                                    color: primarycolor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              inputTextField(
                                  validator: (text) {
                                    if (text!.length == 0 ||
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
                                  controller:
                                      LoginCubit.get(context).emailController),

                              SizedBox(height: 16),

                              inputTextField(
                                  validator: (text) {
                                    if (text!.isEmpty) {
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
                                      LoginCubit.get(context).changeicon
                                          ? false
                                          : true,
                                  icon: IconButton(
                                      onPressed: () {
                                        LoginCubit.get(context).changeIcon();
                                      },
                                      icon: LoginCubit.get(context).changeicon
                                          ? Icon(
                                              Icons.visibility,
                                              color: primarycolor,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              color: Color(0xFF979797),
                                            )),
                                  controller: LoginCubit.get(context)
                                      .passwordController),
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
                                  condition: state is! Loadingstate,
                                  builder: (context) => GestureDetector(
                                        onTap: () {
                                          if (formstate.currentState!
                                              .validate()) {
                                            cubit.UserLogin();
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
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  fallback: (context) => Center(
                                        child: CircularProgressIndicator(),
                                      )),
                              SizedBox(height: 18),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '__OR__',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color.fromARGB(
                                              255, 238, 235, 235),
                                          padding: EdgeInsets.all(10),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {},
                                      label: Text(
                                        "Login with google",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: primarycolor,
                                        ),
                                      ),
                                      icon: Image(
                                        image: AssetImage("assets/gog.png"),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Spacer(),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account ?",
                                      style: TextStyle(color: Colors.black54)),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(Register());
                                      },
                                      child: Text(
                                        "Sign Up",
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
