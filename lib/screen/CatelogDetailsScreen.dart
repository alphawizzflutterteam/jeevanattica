import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/orderconfirm2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';
import '../Model/ProductDetailsByIdModel.dart';
import '../Utils/ApiBaseHelper.dart';
import '../Utils/constant.dart';
import '../Model/CatelogDetailsModel.dart';

class CatelogDetailsScreen extends StatefulWidget {
  Data? data;

  CatelogDetailsScreen(this.data);

  @override
  State<CatelogDetailsScreen> createState() => _CatelogDetailsScreenState();
}

class _CatelogDetailsScreenState extends State<CatelogDetailsScreen> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  Data? productModel = Data();
  bool isLoading = true;

  getProductById() async {
    productModel =widget.data;
    if (productModel != null && productModel?.image != null) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProductById();
  }

  bool isNetwork = false;



  bool loading = true;



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor:Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
            ),
            title: Text(
              "Jewellery Details",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyCart()));
                },
                child: Image.asset(
                  "assets/images/shop.png",
                  height: 20,
                  width: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  "assets/images/well.png",
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),

          body: !isLoading
              ? ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        commonHWImage(productModel?.image, 258.00,
                            350.0, "", context, "assets/homepage/gold.png"),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(getWidth(10)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Our Price = ₹${productModel?.price}",
                              style: TextStyle(color: Colors.black,fontSize: 22),

                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Total Grams = ${productModel?.weight}",
                              style: TextStyle(color: Colors.black87, fontSize: 22),

                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "MRP = ${productModel?.mrp}",
                              style: TextStyle(color: Colors.black87, fontSize: 22),

                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox()),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      var currentIndex;
      if (currentIndex == i) {
        var currentIndex;
        if (currentIndex == 3) {
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color:colors.secondary2,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        } else {}
      } else {}
    }

    return indicators;
  }
}
