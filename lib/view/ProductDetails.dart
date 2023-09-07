// ignore_for_file: public_member_api_docs, sort_constructors_first, use_key_in_widget_constructors, non_constant_identifier_names, must_be_immutable, sized_box_for_whitespace
// ignore_for_file: unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopapp/Widgets.dart';
import 'package:shopapp/constants/colors.dart';
import 'package:shopapp/view/DiscriptionScreen.dart';

class ProductDetailsScreen extends StatelessWidget {
  String title;
  String image;
  String price;
  String old_pric;
  String discription;
  int discount;
  ProductDetailsScreen({
    required this.title,
    required this.image,
    required this.price,
    required this.old_pric,
    required this.discount,
    required this.discription,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.9,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.contain)),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.blueGrey[100]),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 21,
                                ),
                              ),
                              Spacer(),
                              if (discount != 0)
                                Text(
                                  old_pric,
                                  style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey),
                                ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(price, style: TextStyle(fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  DiscriptionScreen(Discription: discription));
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                discription,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 14,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Check Out",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
