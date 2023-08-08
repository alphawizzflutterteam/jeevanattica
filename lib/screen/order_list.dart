import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/myAccount.dart';
import 'package:atticadesign/Helper/myCart.dart';

import 'package:atticadesign/Model/category_model.dart';
import 'package:atticadesign/Model/order_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/String.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/screen/cart_product_view.dart';
import 'package:atticadesign/screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';
import '../Utils/Common.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  int totalCount = 0;
  int? currentIndex;
  String productImage = "", productName = "";
  bool loading = true;
  bool loadingWish = false;
  List<OrderModel> orderList = [];
  getOrderList() async {
    try {
      setState(() {
        loadingWish = false;
        orderList.clear();
      });
      Map params = {
        "get_favorites": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "limit": "10",
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_orders"), params);
      setState(() {
        loadingWish = true;
      });
      if (!response['error']) {
        for(var v in response['data']){
          setState(() {
            orderList.add(new OrderModel.fromJson(v));
          });
        }
      } else {
        setState(() {
          likeCount =0;
        });
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loadingWish = true;
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0F261E),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
            ),
          ),
          title: Text(
            "Order History",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                  onTap: () {
                  },
                  child: Icon(Icons.notifications_active,
                      color:colors.secondary2)),
            ),
          ],
        ),
        body:
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
          child: Column(
            children: [
              boxHeight(30),
              loadingWish
                  ? orderList.length > 0
                  ? Expanded(
                child: ListView.builder(
                    itemCount: orderList.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return OrderView(orderList[index],()async{
                        var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsScreen(orderList[index])));
                      },);
                    }),
              )
                  : Expanded(
                child: Center(
                  child: text("No Order Available"),
                ),
              )
                  : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyColorName.primaryDark,
                  ),
                ),
              ),
              boxHeight(20),

            ],
          ),
        ));
  }
}
