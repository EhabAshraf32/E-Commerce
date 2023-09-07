// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_typing_uninitialized_variables, sized_box_for_whitespace, non_constant_identifier_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';

import '../Widgets.dart';
import '../model/GetFavourites.dart';

class FavouritesScreen extends StatelessWidget {
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomLayoutCubit, HomLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: ConditionalBuilder(
              condition: state is! ShopLoadingFavouritesState,
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: (state is ShopLoadingFavouritesState)
                    ? SafeArea(
                        child: LinearProgressIndicator(
                          backgroundColor: Color.fromARGB(10, 0, 0, 0),
                          color: Colors.black,
                        ),
                      )
                    : (state is ShopChangeFavouritesSuccessState)
                        ? SafeArea(
                            child: LinearProgressIndicator(
                              backgroundColor: Color.fromARGB(10, 0, 0, 0),
                              color: Colors.black,
                            ),
                          )
                        : ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              width = MediaQuery.of(context).size.width;
                              height = MediaQuery.of(context).size.width;
                              return BuildListProduct(
                                  context,
                                  HomLayoutCubit.get(context)
                                      .GetFavouritesModel
                                      ?.data
                                      .data[index]
                                      .product);
                            },
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: HomLayoutCubit.get(context)
                                .GetFavouritesModel!
                                .data
                                .data
                                .length),
              ),
            ));
      },
    );
  }
}
