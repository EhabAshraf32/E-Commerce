// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shopapp/Widgets.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'package:shopapp/view/Changepassword.dart';

import '../constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //HomLayoutCubit.get(context).getSeetings();

    var formkey = GlobalKey<FormState>();

    return BlocConsumer<HomLayoutCubit, HomLayoutState>(
      listener: (context, state) {
        if (state is ShopGetSettingsSuccessState) {
          // final settingsModel = state.settingsModel;
          // HomLayoutCubit.get(context).namecontroller.text =
          //     settingsModel.data?.name ?? 'ss';
          // HomLayoutCubit.get(context).emailcontroller.text =
          //     settingsModel.data?.email ?? 'ss';
          // HomLayoutCubit.get(context).phonecontroller.text =
          //     settingsModel.data?.phone ?? 'ss';
        }
      },
      builder: (context, state) {
        var model = HomLayoutCubit.get(context).settingsModels;

        final phone = model?.data?.phone ?? '';
        final email = model?.data?.email ?? '';
        final name = model?.data?.name ?? '';

        HomLayoutCubit.get(context).phonecontroller.text = phone;
        HomLayoutCubit.get(context).emailcontroller.text = email;
        HomLayoutCubit.get(context).namecontroller.text = name;
        return ConditionalBuilder(
            condition: state is! ShopLoadingSettingsState,
            builder: (context) => SafeArea(
                  child: Scaffold(
                      body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is ShopLoadingUpdateState)
                            LinearProgressIndicator(
                              backgroundColor: Color.fromARGB(10, 0, 0, 0),
                              color: Colors.black,
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            //enabled: false,
                            controller:
                                HomLayoutCubit.get(context).namecontroller,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                label: Text("Name"),
                                prefixIcon: Icon(Icons.account_circle_outlined,
                                    color: Color(0xFF979797)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16)),
                            validator: (text) {
                              if (text!.length == 0) {
                                return "Name must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller:
                                HomLayoutCubit.get(context).emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                label: Text("Email Address"),
                                prefixIcon:
                                    Icon(Icons.email, color: Color(0xFF979797)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16)),
                            validator: (text) {
                              if (text!.length == 0 || !text.contains("@")) {
                                return "email must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller:
                                HomLayoutCubit.get(context).phonecontroller,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                label: Text("phone"),
                                prefixIcon:
                                    Icon(Icons.phone, color: Color(0xFF979797)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kPrimaryColor)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                labelStyle: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 16)),
                            validator: (text) {
                              if (text!.length == 0) {
                                return "phone must not be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Get.to(ChangepasswordScreen());
                                  },
                                  child: Text(
                                    "Change Passord",
                                    style: TextStyle(color: primarycolor),
                                  ))
                            ],
                          ),
                          CustomButton(
                              context: context,
                              text: "Update Your Details",
                              OnPressed: () {
                                if (formkey.currentState!.validate()) {
                                  HomLayoutCubit.get(context).updateUserData();
                                }
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              context: context,
                              text: "Sign Out",
                              OnPressed: () {
                                SignOut();
                              })
                        ],
                      ),
                    ),
                  )),
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}
