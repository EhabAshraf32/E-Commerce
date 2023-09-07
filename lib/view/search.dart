// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controller/Search/cubit/search_cubit_cubit.dart';

import '../Widgets.dart';
import '../constants/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  var formkey = GlobalKey<FormState>();
  var controller = TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
                body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      // onFieldSubmitted: (value) {
                      //   SearchCubit.get(context).SearchProduct(text: value);
                      //   print(value);
                      // },
                      onChanged: (value) {
                        SearchCubit.get(context).SearchProduct(text: value);
                        print(value);
                      },
                      autofocus: true,
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          suffixIcon:
                              Icon(Icons.search, color: Color(0xFF979797)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text("Search"),
                          labelStyle: TextStyle(
                              color: Colors.grey.shade700, fontSize: 18)),
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "the field must not be empty";
                        }
                        return null;
                      },
                      //autovalidateMode: AutovalidateMode.always,
                    ),
                    if (state is SearchLoadingChangeState)
                      LinearProgressIndicator(
                        backgroundColor: Color.fromARGB(10, 0, 0, 0),
                        color: Colors.black,
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessChangeState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return BuildListProduct(
                                  context,
                                  SearchCubit.get(context)
                                      .model!
                                      .data
                                      .data[index],
                                  isOldPrice: false);
                            },
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data
                                .data
                                .length),
                      )
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
