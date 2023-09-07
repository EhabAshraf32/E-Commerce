// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Widgets.dart';
import '../constants/colors.dart';
import '../controller/Login/login_cubit.dart';

class ChangepasswordScreen extends StatelessWidget {
  ChangepasswordScreen({super.key});
  var formstate = GlobalKey<FormState>();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is ChangePasswordSucessfullState) {
          if (state.model.status) {
            snackbar(
                type: "Success",
                message:
                    state.model.message, // Access directly from state.model
                color: HexColor("#1B5E20"));
            print(state.model.message);
          } else if (state.model.status == false) {
            snackbar(
                type: "Error",
                message:
                    state.model.message, // Access directly from state.model
                color: HexColor("#990000"));
            print(state.model.message);
          }
        } else if (state is ChangePasswordErrorState) {
          snackbar(
              type: "Error",
              message: state.error, // Access directly from state.model
              color: HexColor("#1B5E20"));
        }
      }, builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Form(
                key: formstate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: oldpasswordController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                          label: Text("Old Password"),
                          labelStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15)),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Password can not be Empty";
                        }
                        if (text.length < 6) {
                          return "Please Enter your password correctly";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText:
                          LoginCubit.get(context).changeicon ? false : true,
                      controller: newpasswordController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          suffixIcon: IconButton(
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
                          hintStyle: TextStyle(color: Colors.black),
                          label: Text("New Password"),
                          labelStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 15)),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Password can not be Empty";
                        }
                        if (text.length < 6) {
                          return "Please Enter your password correctly";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ConditionalBuilder(
                        condition: state is! ChangePasswordLoadingState,
                        builder: (context) {
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
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formstate.currentState!.validate()) {
                                    LoginCubit.get(context).ChangePassowrd(
                                        old_password:
                                            oldpasswordController.text,
                                        new_password:
                                            newpasswordController.text);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Check Out",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          );
                        },
                        fallback: (context) => Center(
                              child: CircularProgressIndicator(),
                            ))
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
