// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controller/homeLayout/cubit/hom_layout_cubit.dart';
import 'package:shopapp/model/CategoriesModel.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomLayoutCubit, HomLayoutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: ListView.separated(
                itemBuilder: (context, index) {
                  width = MediaQuery.of(context).size.width;
                  height = MediaQuery.of(context).size.width;
                  return categoriesListTile(HomLayoutCubit.get(context)
                      .categoriesData
                      ?.data
                      .data[index]);
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey,
                    ),
                itemCount: HomLayoutCubit.get(context)
                    .categoriesData!
                    .data
                    .data
                    .length));
      },
    );
  }

  Widget categoriesListTile(DataDetails? model) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: width / 5,
              height: height / 5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  image:
                      DecorationImage(image: NetworkImage("${model?.image}"))),
            ),
            SizedBox(
              width: width / 15,
            ),
            Text(
              "${model?.name}",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
          ],
        ));
  }
}
