import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/orderconfirm2.dart';
import 'package:atticadesign/screen/cart_product_view.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/Common.dart';
import 'Color.dart';

class MyCart extends StatefulWidget {
   MyCart({
     Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int type = 0;
  bool isGold = false;
  int? currentIndex;
  List<CartData> cartList = [];
  int totalCount = 0, currentCount = 0;
  String grams ="";
  String productImage = "", productName = "";
  double subTotal = 0,
      deliveryCharge = 0,
      tax = 0,
      totalAmount = 0,
      proDiscount = 0;
  List<CartModel> cartItemList = [];
  getCart() async {
    try {
      setState(() {
        cartList.clear();
      });
      Map params = {
        "get_user_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);

      if (!response['error']) {
        cartList.clear();
        for (var v   in response['cart_data']) {
          setState(() {
            cartList.add(CartData.fromJson(v));
            totalCount = cartList.length;
            // grams = cartList[0].
            // productModel?.product![0].weight;
          });
        }
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  getTotal() async {
    try {
      Map params = {
        "get_user_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);
      setState(() {
        loadingCart = true;
      });
      if (!response['error']) {
        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if (response['delivery_charge'] != null) {
            deliveryCharge =
                double.parse(response['delivery_charge'].toString());
          }
          if (response['total_tax'] != null) {
            tax = double.parse(response['tax_amount'].toString());
          }
          totalAmount = subTotal + deliveryCharge + tax;
        });
      } else {
        setState(() {
          subTotal = 0;
          deliveryCharge = 0;
          tax = 0;
          totalAmount = 0;
        });
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
    if (currentCount == 0) {
      setState(() {
        currentCount = totalCount;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
    getTotal();
  }

  void addCart(i) {
    Map data = {};
    int count = parseInt(cartList[i].qty);
    setState(() {
      count++;
      String? aad = cartList[i].qty.toString();
      aad = count.toString();
      totalCount++;
    });
    data = {
      "add_to_cart": "1",
      "user_id": App.localStorage.getString("userId").toString(),
      "product_id": cartList[i].productId,
      "product_variant_id": cartList[i].productDetails![0].variants![0].id,
      "qty": count.toString(),
      "size" : cartList[i].size.toString()
    };
    print("data @@ $data");
    callApi("manage_cart", data, "", i);
  }

  void removeCart(i) {
    Map data1 = {};

    int count = parseInt(cartList[i].qty);
    if (count == 1) {
      setState(() {
        count--;
        String? aad = cartList[i].qty;
        aad = count.toString();
        totalCount--;
      });

      data1 = {
        "remove_from_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "qty": count.toString(),
        "product_variant_id": cartList[i].productDetails![0].variants![0].id,
        "size" : cartList[i].size.toString()
      };
      print("data ## $data1");
      callApi("manage_cart", data1, "remove", -1);
    } else {
      setState(() {
        count--;
        String? aad = cartList[i].qty;
         aad = count.toString();
        totalCount--;
      });
      data1 = {
        "add_to_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "product_id": cartList[i].productId,
        "product_variant_id": cartList[i].productDetails![0].variants![0].id,
        "qty": count.toString(),
        "size" : cartList[i].size.toString()
      };
      print("data ## $data1");
      print("ok");
      callApi("manage_cart", data1, "", -1);
    }
  }

  void remove(i) {
    Map data;
    data = {
      "remove_from_cart": "1",
      "user_id": App.localStorage.getString("userId").toString(),
      "product_variant_id": cartList[i].productDetails![0].variants![0].id,
        "qty": cartList[i].qty,
      "size" : cartList[i].size.toString()
    };
    print("data ^^ $data");
    callApi("remove_from_cart", data, "remove", -1);
  }

  void callApi(String url, Map data, String check, int i) async {
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        setState(() {
          loading = false;
        });
        Map response =
            await apiBase.postAPICall(Uri.parse(baseUrl + url), data);
        setState(() {
          loading = true;
        });
        if (!response['error']) {
          if (check == "remove") {
            getCart();
            getTotal();
          } else {
            getCart();
            getTotal();
          }
        } else {
          if (i != -1) {
            int count = parseInt(cartList[i].qty);
            setState(() {
              count--;
              var asd =cartList[i].qty;
              asd = count.toString();
              totalCount--;
            });
          }
          setSnackbar(response['message'], context);
        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = true;
        });
      }
    } else {
      setSnackbar("No Internet Available", context);
    }
  }

  Future<bool> backContext() async {
    Navigator.pop(context, totalCount != currentCount ? "refresh" : "");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        leading: InkWell(
            onTap: () {
              if ( cartList.length == 0) {
                Navigator.pop(context, true);
              }else{
                Navigator.pop(context, false);
              }
            },
            child: Icon(
              Icons.arrow_back,
              color: colors.secondary2,
            ),),
        title: Text(
          "Cart",
          style: TextStyle(
            color: colors.black54,
            fontSize: 20,
          ),
        ),
      ),
     // backgroundColor: Color(0xff15654F),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
            child: Column(
              children: [
                boxHeight(20),
                loadingCart
                    ? cartList.length > 0
                        ? ListView.builder(
                            itemCount: cartList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              cartList[index].productDetails![0].categoryName == "Gold" ?
                                  type = 1 : type = 2;
                              return CartProductView(
                                  cartList[index], () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    removeCart(index);
                                  }, () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    addCart(index);
                                  },
                                  () {},
                                  () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (ctxt) => new AlertDialog(
                                        backgroundColor: colors.secondary2,
                                        title: Text("Are you sure you want to remove this product",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: colors.blackTemp
                                        ),),
                                        actions: [
                                          TextButton(
                                              onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text("Cancel",
                                          style: TextStyle(
                                            color: colors.blackTemp
                                          ),)),

                                          TextButton(
                                              onPressed: (){
                                            remove(index);
                                            Navigator.pop(context);
                                          }, child: Text("Yes",
                                            style: TextStyle(
                                                color: colors.blackTemp
                                            ),
                                          )),
                                          // GestureDetector(
                                          //   child: Text("Cancel"),
                                          //   onTap: (){
                                          //     Navigator.pop(context);
                                          //   },
                                          // ),
                                          // GestureDetector(
                                          //   child: Center(child: Text("Yes")),
                                          //   onTap: (){
                                          //     remove(index);
                                          //     Navigator.pop(context);
                                          //   },
                                          // )
                                        ],
                                      ),
                                    );


                                  },
                                  currentIndex == index ? loading : true);
                            })
                        : Container(
                            height: getHeight(600),
                            child: Center(
                              child: text("No Items Available"),
                            ),
                          )
                    : Container(
                        height: getHeight(600),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: MyColorName.primaryDark,
                          ),
                        ),
                      ),
                boxHeight(35),
                cartList.length > 0 ? priceView() : SizedBox.shrink(),
                boxHeight(40),
                cartList.length > 0
                    ? InkWell(
                        onTap: () {
                          print("this is type $type");
                          cartList[0].productDetails![0].categoryName.toString() == "Gold 916" ?
                              isGold = true
                          : isGold = false;
                          navigateScreen(
                              context,
                              OrderConfirm2(
                                isGold: isGold,
                                  gramValue: "", itemCount: totalCount,
                              type: type,
                               buyNow: false,));
                        },
                        child: Container(
                          width: getWidth(320),
                          height: getHeight(50),
                          decoration: boxDecoration(
                              radius: 48, bgColor: MyColorName.primaryDark),
                          child: Center(
                            child: text(
                              "Proceed To Buy ( ${cartList.length.toString()} Items )",
                              fontFamily: fontMedium,
                              textColor: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                cartList.length > 0 ? boxHeight(120) : SizedBox.shrink(),
                cartList.length < 2 ? boxHeight(400) : boxHeight(10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  priceView() {
    return Container(
      width: getWidth(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.5),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(29), vertical: getHeight(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Sub Total ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$subTotal",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Delivery Charges",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$deliveryCharge",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(proDiscount > 0 ? 22 : 0),
          proDiscount > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      "Pro Discount",
                      fontSize: 10.sp,
                      fontFamily: fontRegular,
                    ),
                    text(
                      "-₹$proDiscount",
                      fontSize: 10.sp,
                      fontFamily: fontBold,
                    ),
                  ],
                )
              : SizedBox(),
          boxHeight(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Tax",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹$tax",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(22),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total",
                fontSize: 10.sp,
                fontFamily: fontSemibold,
              ),
              text(
                "₹$totalAmount",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
