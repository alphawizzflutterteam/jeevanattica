import 'dart:async';
import 'dart:convert';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/paynow.dart';
import 'package:atticadesign/Model/address_model.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Razorpay.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/order _Confirmed.dart';
import 'Model/UserDetailsModel.dart';
import 'Utils/Common.dart';
import 'screen/address_list_view.dart';

class OrderConfirm2 extends StatefulWidget {
  final String gramValue;
  final itemCount;
  final bool isGold;
  final int type;
  final bool buyNow;
  const OrderConfirm2({Key? key, required this.gramValue, this.itemCount, required this.isGold, required this.type, required this.buyNow}) : super(key: key);

  @override
  State<OrderConfirm2> createState() => _OrderConfirm2State();
}

class _OrderConfirm2State extends State<OrderConfirm2> {
  TextEditingController controller = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  VoucherModel? model;
  bool loading = true;
  String selectTime = "Schedule Delivery time";
  double subTotal = 0,
      deliveryCharge = 0,
      tax = 0,
      taxPer = 0,
  restAmount= 0 ,
      totalAmount = 0,
      tempTotal = 0,
      amountPasValue = 0,
      proDiscount = 0;
  String? size;
  double? voucher;
  bool isWallet = false;
  bool isGoldWallet = false;
  bool isSilverWallet = false;
  bool isRazor = false;
  TextEditingController choiceAmountController = TextEditingController();


  getTotal() async {
    try {
      Map params = {
        "get_user_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);
      setState(() {
        loading = true;
      });
      if (!response['error']) {

          // for (var v in response['cart_data']) {
          //   setState(() {
          //     productId.add(v['product_variant_id']);
          //     quantity.add(v['qty']);
          //     tax = response['tax_amount'];
          //     taxPer = response['tax_percentage'];
          //   });
          // }
          // print("@@ this is ${productId} && ${quantity}");

        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if (response['delivery_charge'] != null) {
            deliveryCharge =
                double.parse(response['delivery_charge'].toString());
          }
          if (response['tax_amount'] != null) {
            tax = double.parse(response['tax_amount'].toString());
            taxPer = double.parse(response['tax_percentage']);
          }

          totalAmount = subTotal + deliveryCharge + tax;
          tempTotal = totalAmount;
        });
      } else {}
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }

  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "final_total": subTotal.toString(),
        "promo_code": promoCode.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          totalAmount =
              double.parse(response['data'][0]['final_total'].toString()) +
                  deliveryCharge +
                  tax;
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }

  bool saveStatus = true;
  List<String> typeList = ["Home", "Office", "Other"];
  String? selectType;
  List<AddModel> addressList = [];

  getAddress() async {
    try {
      setState(() {
        curIndex = null;
        selectType = null;
        addressList.clear();
        saveStatus = false;
      });
      Map params = {
        "get_addresses": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response =
          await apiBase.postAPICall(Uri.parse(baseUrl + "get_address"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            if (v['type'] != "") {
              addressList.add(new AddModel.fromJson(v));
            }
          });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  // void getWallet() async {
  //   userDetailsModel =
  //   await userDetails(App.localStorage.getString("userId").toString());
  //   if (userDetailsModel != null &&
  //       userDetailsModel.data![0].silverWallet != null &&
  //       userDetailsModel.data![0].silverWallet != "") {
  //     setState(() {
  //       print(userDetailsModel.data![0].silverWallet.toString());
  //       availebaleSilveGram =
  //           double.parse(userDetailsModel.data![0].silverWallet.toString());
  //       silverWallet =
  //           double.parse(userDetailsModel.data![0].silverWallet.toString()) *
  //               silverGram;
  //     });
  //   }
  //   if (userDetailsModel != null &&
  //       userDetailsModel.data![0].goldWallet != null &&
  //       userDetailsModel.data![0].goldWallet != "") {
  //     setState(() {
  //       print(userDetailsModel.data![0].goldWallet.toString());
  //       availeGoldgram =
  //           double.parse(userDetailsModel.data![0].goldWallet.toString());
  //       goldenWallet =
  //           double.parse(userDetailsModel.data![0].goldWallet.toString()) *
  //               goldGram;
  //     });
  //   }
  //   if (userDetailsModel != null &&
  //       userDetailsModel.data![0].balance != null &&
  //       userDetailsModel.data![0].balance != "") {
  //     setState(() {
  //       print(userDetailsModel.data![0].balance.toString());
  //       totalBalance =
  //           double.parse(userDetailsModel.data![0].balance.toString());
  //     });
  //   }
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
    getAddress();
    getTotal();
    getWallet();
  }

 /* void addCart(i) {
    Map data1 = {};
    Map data = {};

    data = {
      "add_to_cart": "1",
      "user_id": App.localStorage.getString("userId").toString(),
      "product_id": widget.productId,
      "product_variant_id": cartList[i].productDetails![0].variants![0].id,
      "qty": cartList[i].qty,
    };
    callApi("manage_cart", data, "", i);
  }*/


  double priceRange = 0;
  int? curIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: colors.secondary2,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primaryNew,
          //colors.secondary2,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
          ),
          title: Text(
            "Order Confirm",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),

        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: getWidth1(49)),
            decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage(
            //     'assets/homepage/vertical.png',
            //   ),
            //   fit: BoxFit.cover,
            // )
            ),
            child: Column(
              children: [

                boxHeight(40),
                Container(
                  decoration: boxDecoration(
                    bgColor: colors.secondary2,
                    radius: 10,
                  ),
                  padding: EdgeInsets.all(getWidth1(10)),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    iconSize: getHeight(40),
                    dropdownColor: colors.secondary2,
                    isDense: true,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    iconEnabledColor: MyColorName.primaryDark,
                    value: selectType,
                    items: typeList.map((p) {
                      return DropdownMenuItem<String>(
                        value: p,
                        child: text(p,
                            fontSize: 12.sp,
                            fontFamily: fontMedium,
                            textColor: colors.blackTemp),
                      );
                    }).toList(),
                    hint: text("Choose Address Type",
                        fontSize: 12.sp,
                        fontFamily: fontMedium,
                        textColor: colors.blackTemp),
                    onChanged: (value) {
                      setState(() {
                        selectType = value;
                        curIndex = null;
                      });
                      int i = addressList.indexWhere((element) =>
                          element.type!.toLowerCase() ==
                          selectType!.toLowerCase());
                      if (i != -1) {
                        setState(() {
                          curIndex = i;
                        });
                      } else {}
                    },
                  ),
                ),
                boxHeight(10),
                Container(
                  decoration: boxDecoration(
                    bgColor: colors.secondary2,
                    radius: 10,
                  ),
                  padding: EdgeInsets.all(getWidth1(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: colors.blackTemp,
                              ),
                              boxWidth(10),
                              text("Delivery Address",
                                  fontSize: 10.sp,
                                  fontFamily: fontMedium,
                                  textColor: colors.blackTemp),
                            ],
                          ),
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            color: colors.secondary2,
                            onSelected: (value) async {
                              var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddressList(false, false)),
                              );
                              if (result) {
                                getAddress();
                              }
                            },
                            itemBuilder: (BuildContext bc) {
                              return const [
                                PopupMenuItem(
                                  child: InkWell(
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.edit,
                                        color: colors.blackTemp,
                                      ),
                                      title: Text(
                                        "Edit",
                                        style: TextStyle(color: colors.blackTemp),
                                      ),
                                    ),
                                  ),
                                  value: 'Edit',
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.add_circle_outline,
                                      color: colors.blackTemp,
                                    ),
                                    title: Text(
                                      "Add",
                                      style: TextStyle(color: colors.blackTemp),
                                    ),
                                  ),
                                  value: 'Add',
                                ),
                                PopupMenuItem(
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.delete_forever,
                                      color: colors.blackTemp,
                                    ),
                                    title: Text(
                                      "Delete",
                                      style: TextStyle(color: colors.blackTemp),
                                    ),
                                  ),
                                  value: 'Delete',
                                )
                              ];
                            },
                          ),
                        ],
                      ),
                      boxHeight(5),
                      InkWell(
                        onTap: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddressList(false, false)),
                          );
                          if (result) {
                            getAddress();
                          }
                        },
                        child: text(
                            curIndex != null
                                ? addressList[curIndex!].address.toString()
                                : "Select Or Add Address",
                            fontSize: 10.sp,
                            fontFamily: fontMedium,
                            textColor: colors.blackTemp),
                      ),
                      boxHeight(5),
                      Divider(),
                      TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          filled: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          prefixIcon: Container(
                            height: getHeight1(16),
                            width: getWidth1(16),
                            padding: EdgeInsets.all(getWidth1(10)),
                            child: Icon(
                              Icons.speaker_notes,
                              color: colors.blackTemp,
                            ),
                          ),
                          label: text("Add Notes For Your Delivery",
                              fontFamily: fontRegular),
                        ),
                      )
                    ],
                  ),
                ),

                boxHeight(35),
                voucherView(),
                model != null ? boxHeight(35) : SizedBox(),
                model != null ? promoCode() : SizedBox(),
                boxHeight(16),

                text(
                  "Payment Mode",
                  fontFamily: fontMedium,
                  fontSize: 14.sp,
                  textColor: colors.blackTemp,
                ),
                boxHeight(16),
                paymentMode(),
                boxHeight(16),
                text(
                  "Product Details",
                  fontFamily: fontMedium,
                  fontSize: 14.sp,
                  textColor: colors.blackTemp,
                ),
                boxHeight(16),
                loadingCart
                    ? cartList.length > 0
                    ? ListView.builder(
                    itemCount: cartList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // cartList[index].
                      // productDetails![0].categoryName == "Gold" ?
                      // type = 1 : type = 2;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: colors.secondary2
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${cartList[index].name.toString()}",
                              style: TextStyle(
                                color: colors.blackTemp,
                                fontWeight: FontWeight.w500
                              ),),
                              // Text("Qty: ${cartList[index].qty.toString()}",
                              //   style: TextStyle(
                              //       color: colors.blackTemp,
                              //       fontWeight: FontWeight.w500
                              //   ),),
                              Text("₹ ${cartList[index].specialPrice.toString()} x ${cartList[index].qty.toString()}",
                                style: TextStyle(
                                    color: colors.blackTemp,
                                    fontWeight: FontWeight.w500
                                ),)
                            ],
                          ),
                        ),
                      );
                      //   CartProductView(
                      //     cartList[index], () {
                      //   setState(() {
                      //     currentIndex = index;
                      //   });
                      //   // removeCart(index);
                      // }, () {
                      //   setState(() {
                      //     currentIndex = index;
                      //   });
                      //   // addCart(index);
                      // },
                      //         () {},
                      //         () {
                      //       setState(() {
                      //         currentIndex = index;
                      //       });
                      //       showDialog(
                      //         context: context,
                      //         builder: (ctxt) => new AlertDialog(
                      //           backgroundColor: colors.secondary2,
                      //           title: Text("Are you sure you want to remove this product",
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.normal,
                      //                 color: colors.blackTemp
                      //             ),),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: (){
                      //                   Navigator.pop(context);
                      //                 }, child: Text("Cancel",
                      //               style: TextStyle(
                      //                   color: colors.blackTemp
                      //               ),)),
                      //
                      //             TextButton(
                      //                 onPressed: (){
                      //                   remove(index);
                      //                   Navigator.pop(context);
                      //                 }, child: Text("Yes",
                      //               style: TextStyle(
                      //                   color: colors.blackTemp
                      //               ),
                      //             )),
                      //             // GestureDetector(
                      //             //   child: Text("Cancel"),
                      //             //   onTap: (){
                      //             //     Navigator.pop(context);
                      //             //   },
                      //             // ),
                      //             // GestureDetector(
                      //             //   child: Center(child: Text("Yes")),
                      //             //   onTap: (){
                      //             //     remove(index);
                      //             //     Navigator.pop(context);
                      //             //   },
                      //             // )
                      //           ],
                      //         ),
                      //       );
                      //
                      //
                      //     },
                      //     currentIndex == index ? loading : true);
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
                boxHeight(16),
                text(
                  "Your Cart Summary",
                  fontFamily: fontMedium,
                  fontSize: 14.sp,
                  textColor: colors.blackTemp,
                ),
                boxHeight(16),
                priceView(),
                boxHeight(15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48,
                            bgColor: colors.secondary2,
                            color: colors.secondary2,),
                        child: Center(
                          child: text("Cancel",
                              fontFamily: fontMedium,
                              fontSize: 22,
                              textColor: colors.blackTemp),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (curIndex == null) {
                          setSnackbar("Please Select or Add Address", context);
                          return;
                        }
                        addressId = addressList[curIndex!].id.toString();
                        latitude = double.parse(
                            addressList[curIndex!].latitude.toString());
                        longitude = double.parse(
                            addressList[curIndex!].longitude.toString());
                        if(isWallet || isGoldWallet || isSilverWallet){
                          orderWithWaleet();
                        }else{
                          var a = double.parse(totalAmount.toString()) * 100;
                          RazorPayHelper razorHelper = new RazorPayHelper(
                              totalAmount.toString(), context, (result) {
                            if (result == "success") {
                              addOrder();
                            } else {
                              // addOrder();
                            }
                          }, App.localStorage.getString("userId").toString(),
                              widget.gramValue.toString(), false, true);
                          razorHelper.initiated(true, amount: a.toString());
                          // addOrder();
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => PayNow(
                        //           voucher,
                        //           totalAmount,
                        //           model,
                        //           "",
                        //           controller.text,
                        //           subTotal + tax,
                        //           "NotAvailable",
                        //           deliveryCharge.toString(),
                        //           widget.gramValue, widget.isGold)),
                        // );
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48, bgColor: colors.secondary2),
                        child: Center(
                          child: text("Pay Now",
                              fontFamily: fontMedium,
                              fontSize: 22,
                              textColor: colors.blackTemp),
                        ),
                      ),
                    ),
                  ]
                ),
                boxHeight(30),
              ],
            ),
          )),
        ),

      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.all(20),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Expanded(
      //         flex: 1,
      //         child:
      //         InkWell(
      //           onTap: () {
      //             var a = double.parse(totalAmount.toString()) * 100;
      //             RazorPayHelper razorHelper = new RazorPayHelper(
      //                 totalAmount.toString(), context, (result) {
      //               if (result == "error") {
      //                 setState(() {
      //                   saveStatus = true;
      //                 });
      //               } else {
      //                 addOrder();
      //               }
      //             }, App.localStorage.getString("userId").toString(),
      //                 widget.gramValue.toString(), false, true);
      //             razorHelper.init(true, amount: a.toString());
      //           },
      //           child: Container(
      //             height: getHeight1(80),
      //             width: getWidth1(400),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(23.0),
      //                 gradient: LinearGradient(
      //                   colors: [Color(0xffF1D459), Color(0xffB27E29)],
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                 )),
      //             child: Center(
      //               child: saveStatus
      //                   ? Text(
      //                 "PAYMENT Razor Pay",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     color: colors.white1,
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.bold),
      //               )
      //                   : CircularProgressIndicator(
      //                 color: MyColorName.colorTextFour,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 16,
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: isDetailsSHiw ? InkWell(
      //           onTap: () {
      //             orderWithWaleet();
      //           },
      //           child: Container(
      //             height: getHeight1(80),
      //             width: getWidth1(400),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(23.0),
      //                 gradient: LinearGradient(
      //                   colors: [Color(0xffF1D459), Color(0xffB27E29)],
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                 )),
      //             child: Center(
      //               child: saveStatus
      //                   ? Text(
      //                 "PAYMENT Wallet Pay",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     color: colors.white1,
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.bold),
      //               )
      //                   : CircularProgressIndicator(
      //                 color: MyColorName.colorTextFour,
      //               ),
      //             ),
      //           ),
      //         ) : InkWell(
      //           onTap: () {
      //             setState(() {
      //               isWaleetUser = true;
      //             });
      //           },
      //           child: Container(
      //             height: getHeight1(80),
      //             width: getWidth1(400),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(23.0),
      //                 gradient: LinearGradient(
      //                   colors: [Color(0xffF1D459), Color(0xffB27E29)],
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                 )),
      //             child: Center(
      //               child: saveStatusGold
      //                   ? Text(
      //                 "PAYMENT Wallet",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                     color: colors.white1,
      //                     fontSize: 15,
      //                     fontWeight: FontWeight.bold),
      //               )
      //                   : CircularProgressIndicator(
      //                 color: MyColorName.colorTextFour,
      //               ),
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );

  }
  addOrder() async {
    App.init();
    try {
      setState(() {
        saveStatus = false;
      });

      double amount = 0;
      print(amount);
      Map params = {
        "place_order": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "mobile": App.localStorage.getString("phone").toString(),
        "order_note":
        controller.text.toString() != "" ? controller.text.toString() : "No Note",
        "product_variant_id":
        productId.toString().replaceAll("[", "").replaceAll("]", ""),
        "quantity": quantity.toString().replaceAll("[", "").replaceAll("]", ""),
        "total": subTotal.toString(),
        "delivery_charge": deliveryCharge.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "tax_amount": tax.toString(),
        "tax_percentage": taxPer.toString(),
        "wallet_balance": "0",
        "is_wallet_used": "0",
        "booking_order1": "0",
        "goldwallet_used": "0",
        "silver_wallet_used": "0",
        "wallet_balance_used": "0",
        "address_id": addressId.toString(),
        "final_total": totalAmount.toString(),
        "pro_discount": proDiscount.toString(),
        "payment_method": "Razorpay",
        "delivery_time": selectTime.toString() == ""
            ? "Express Delivery"
            : jsonEncode(selectTime).toString(),
        "accesskey": "90336".toString(),
        "status": "received",
      };
      if (model != null) {
        params['promo_code'] = model!.promo_code.toString();
        params['promo_discount'] =
        voucher.toString() != null ? voucher.toString() : "";
      }
      print("order place without wallet @@@ successful ${params.toString()}");
      print(baseUrl + "place_order");
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "place_order"), params);

      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        navigateScreen(context, OrderConfirmed());
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }

  promoCode() {
    return Container(
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(16), vertical: getHeight1(21)),
      child: Column(
        children: [
          Container(
              width: getWidth1(622),
              child: text("Applied Promo Code",
                  fontSize: 10.sp, fontFamily: fontRegular)),
          boxHeight(12),
          Container(
            width: getWidth1(500),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(model!.promo_code,
                        textColor: MyColorName.primaryDark,
                        fontSize: 12.sp,
                        fontFamily: fontMedium),
                    text(model!.message,
                        textColor: MyColorName.primaryDark,
                        fontSize: 8.sp,
                        fontFamily: fontRegular),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      model = null;
                      voucher = null;
                      getTotal();
                    });
                  },
                  child: Container(
                    width: getWidth1(48),
                    height: getWidth1(48),
                    decoration: boxDecoration(
                        radius: 100, bgColor: colors.secondary2),
                    child: Center(
                        child: Icon(
                      Icons.close,
                      size: 20,
                      color: MyColorName.colorTextFour,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  priceView() {
    return Container(
      width: getWidth1(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(29), vertical: getHeight1(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total MRP",
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
          boxHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Sub Total (${widget.itemCount} Items)",
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
          voucher != null ? boxHeight(12) : SizedBox(),
          voucher != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      "Voucher Discount",
                      fontSize: 10.sp,
                      fontFamily: fontRegular,
                    ),
                    text(
                      "-₹$voucher",
                      fontSize: 10.sp,
                      fontFamily: fontBold,
                    ),
                  ],
                )
              : SizedBox(),
          boxHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total grams",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "${widget.gramValue} gms",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight( widget.buyNow == true &&  size != null ? 12 : 0),
          widget.buyNow == true && size != null ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Size",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "$size",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          )
          : SizedBox(height: 0,),
          boxHeight(12),
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
          boxHeight(proDiscount > 0 ? 12 : 0),
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
          boxHeight(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Tax",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹${tax}",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(12),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     text(
          //       "Tax",
          //       fontSize: 10.sp,
          //       fontFamily: fontRegular,
          //     ),
          //     text(
          //       "₹${tax}",
          //       fontSize: 10.sp,
          //       fontFamily: fontBold,
          //     ),
          //   ],
          // ),
          isWallet || isGoldWallet || isSilverWallet ?
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Wallet Amount Used",
                fontSize: 10.sp,
                fontFamily: fontSemibold,
              ),
              text(
                "-₹${choiceAmountController.text}",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          )
              : SizedBox(height: 0,),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total Amount",
                fontSize: 10.sp,
                fontFamily: fontSemibold,
              ),

              text(
                choiceAmountController.text.isNotEmpty ?
                "₹ $restAmount"
                : "₹ $totalAmount",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  paymentMode() {
    return Container(
      width: getWidth1(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(29), vertical: getHeight1(20)),
      child: Column(
        children: [
          Container(
            height: 50,
            child: CheckboxListTile(
              title: Text("Wallet : ₹ ${balance.toStringAsFixed(2)}"),
              value: isWallet,
              activeColor: colors.secondary2,
              checkColor: colors.blackTemp,
              onChanged: (value) {
                setState(() {
                  isWallet = value!;
                  isGoldWallet = false;
                  isSilverWallet = false;
                  // _roomController.text = '${item.id}';
                  // print('${_roomController.text}');
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
          widget.isGold == true?
          Container(
            height: 50,
            child: CheckboxListTile(
              title: Text("Gold-916 Wallet : ₹ ${goldenWallet.toStringAsFixed(2)}"),
              value: isGoldWallet,
              activeColor: colors.secondary2,
              checkColor: colors.blackTemp,
              onChanged: (value) {
                setState(() {
                  isGoldWallet = value!;
                  isWallet = false;
                  isSilverWallet = false;
                  // _roomController.text = '${item.id}';
                  // print('${_roomController.text}');
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          )
           : SizedBox(),
          widget.isGold == false ?
          Container(
            height: 50,
            child: CheckboxListTile(
              title: Text("Gold-999 Wallet : ₹ ${silverWallet.toStringAsFixed(2)}"),
              value: isSilverWallet,
              activeColor: colors.secondary2,
              checkColor: colors.blackTemp,
              onChanged: (value) {
                setState(() {
                  isSilverWallet = value!;
                  isWallet = false;
                  isGoldWallet = false;
                  // _roomController.text = '${item.id}';
                  // print('${_roomController.text}');
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          )
         : SizedBox(),
          isWallet || isGoldWallet || isSilverWallet?
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              controller: choiceAmountController,
              onFieldSubmitted: (value){
                // if (curIndex == null) {
                //   setSnackbar("Please Select or Add Address", context);
                //   return;
                // }
                restAmount = totalAmount - double.parse(choiceAmountController.text);
                // addOrderGold(amountPasValue);

              },
              autofocus: true,
              style: TextStyle(
                fontSize: 24,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusColor: Colors.white,
                // prefixIcon: Icon(
                //   Icons.person_outline_rounded,
                //   color: Colors.grey,
                // ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "₹ Enter amount used from Wallet",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                labelText: '₹ Enter amount used from Wallet',
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
          : SizedBox.shrink(),
          // Container(
          //   height: 50,
          //   child: CheckboxListTile(
          //     title: Text("RazorPay"),
          //     value: isRazor,
          //     activeColor: MyColorName.primaryDark,
          //     checkColor: MyColorName.colorTextPrimary,
          //     onChanged: (value) {
          //       setState(() {
          //         isRazor = value!;
          //         // _roomController.text = '${item.id}';
          //         // print('${_roomController.text}');
          //       });
          //     },
          //     controlAffinity: ListTileControlAffinity.leading,
          //   ),
          // )
        ],
      ),
    );
  }

  voucherView() {
    return Container(
      height: getHeight1(144),
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth1(16),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/buydigitalgold/coupon.png",
            width: getWidth1(79),
            height: getHeight1(54),
            fit: BoxFit.fill,
          ),
          boxWidth(20),
          Container(
              child: text("You have a Voucher",
                  fontSize: 10.sp, fontFamily: fontRegular)),
          boxWidth(20),
          InkWell(
            onTap: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VoucherListView()));
              print(result);
              if (result != null) {
                setState(() {
                  model = null;
                  voucher = null;
                });
                addVoucher(tempTotal, result.promo_code, result);
              }
            },
            child: Container(
              width: getWidth1(160),
              height: getHeight1(55),
              decoration:
                  boxDecoration(radius: 48, bgColor: colors.secondary2),
              child: Center(
                child: text("See All",
                    fontFamily: fontMedium,
                    fontSize: 10.sp,
                    textColor: colors.blackTemp),
              ),
            ),
          ),
        ],
      ),
    );

  }
  bool walletStatus = false;
  // ApiBaseHelper apiBase = new ApiBaseHelper();
  // bool isNetwork = false;
  // bool loading = true;
  bool loadingCart = false;
  int? currentIndex;
  List<CartData> cartList = [];
  List<String> productId = [];
  List<String> quantity = [];
  //bool saveStatus = true,
   bool saveStatusSilve = true, saveStatusGold = true;
  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00,
      goldenWallet = 0.00,
      totalBalance = 0.00,
      silverGram = 52.00,
  balance = 0.00,
      goldGram = 5246.96;
  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  TextEditingController amountWithDerrwa = TextEditingController();

  void getWallet() async {
    userDetailsModel =
    await userDetails(App.localStorage.getString("userId").toString());
    balance = double.parse(userDetailsModel.data![0].balance.toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].silverWallet != null &&
        userDetailsModel.data![0].silverWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].silverWallet.toString());
        availebaleSilveGram =
            double.parse(userDetailsModel.data![0].silverWallet.toString());
        silverWallet =
            double.parse(userDetailsModel.data![0].silverWallet.toString()) *
                silverGram;
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null &&
        userDetailsModel.data![0].goldWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].goldWallet.toString());
        availeGoldgram =
            double.parse(userDetailsModel.data![0].goldWallet.toString());
        goldenWallet =
            double.parse(userDetailsModel.data![0].goldWallet.toString()) *
                goldGram;
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].balance != null &&
        userDetailsModel.data![0].balance != "") {
      setState(() {
        print(userDetailsModel.data![0].balance.toString());
        totalBalance =
            double.parse(userDetailsModel.data![0].balance.toString());
      });
    }

  }

  getCart() async {
    try {
      setState(() {
        loadingCart = false;
        cartList.clear();
      });
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
        for (var v   in response['cart_data']) {
          setState(() {
            cartList.add(CartData.fromJson(v));
            // totalCount = cartList.length;
            // grams = cartList[0].
            // productModel?.product![0].weight;
          });
        }
        for (var v in response['cart_data']) {
          setState(() {
            productId.add(v['product_variant_id']);
            quantity.add(v['qty']);
            // tax = response['tax_amount'];
            // tax = response['tax_percentage'];
          });
        }
        tax = double.parse(response['tax_amount'].toString());
        taxPer = double.parse(response['tax_percentage']);
        size = response['cart_data'][0]['size'].toString();


        print("****${productId.toString()} && ${quantity.toString()}");
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }




  bool isWaleetUser = false;
  //String totalAmount = "";

  addOrderGold(double amountPassValue) async {
    print("wallet amount deducted%%%");
    App.init();
    try {
      setState(() {
        saveStatusGold = false;
      });
      var paymentMod;
      if(totalAmount == choiceAmountController.text){
         paymentMod = "Wallet";
       }else{
        paymentMod = "Wallet & RazorPay";
      }
      print("ok");
      double amount = 0;
      print(amount);
      String? wallet;
      String? walletBalance;
      if(isWallet = true ){
        wallet = "1";
        walletBalance = "${balance.toStringAsFixed(2)}";
      }
      if(isGoldWallet = true) {
        wallet = "2" ;
        walletBalance = "${goldenWallet.toStringAsFixed(2)}";
      }
      if(isSilverWallet = true){
        wallet = "3";
        walletBalance = "${silverWallet.toStringAsFixed(2)}";
      }
      print("this is ^^^ ${productId.toString()} && ${quantity.toString()} and $wallet and also $walletBalance");
      Map params = {
        "place_order": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "mobile": App.localStorage.getString("phone").toString(),
        "order_note":"Not Available",
      //  widget.des.toString() != "" ? widget.des.toString() : "No Note",
        "product_variant_id":
        productId.toString().replaceAll("[", "").replaceAll("]", ""),
        "quantity": quantity.toString().replaceAll("[", "").replaceAll("]", ""),
        "total": totalAmount.toString(),
        "delivery_charge": "${deliveryCharge.toString()}",
        "latitude": "${latitude.toString()}",
        "longitude": "${longitude.toString()}",
        "tax_amount": "${tax.toString()}",
        "tax_percentage": "${taxPer.toString()}",
        "wallet_balance": walletBalance,
        //widget.isGold ?  "${silverWallet.toStringAsFixed(2)}" : "${goldenWallet.toStringAsFixed(2)}",
        "is_wallet_used": wallet,
        "booking_order1": "0",
        "goldwallet_used": widget.isGold == true ? "1" : "",
        //widget.isGold ? "" : "1",
        "silver_wallet_used" : widget.isGold == false ? "1" : "",
        //widget.isGold == false ? "1" : "",
        //widget.isGold ? "1" : "",
        "wallet_balance_used": choiceAmountController.text != "" ?
        "${choiceAmountController.text}"
        :"",
        "address_id": "${addressId.toString()}",
        "final_total": amountPassValue.toString(),
        //"${choiceAmountController.text.toString()}",
        "pro_discount": "${proDiscount.toString()}",
        "payment_method": "${paymentMod.toString()}",
        "delivery_time": selectTime.toString() == ""
            ? "Express Delivery"
            : jsonEncode(selectTime).toString(),
        "accesskey": "90336".toString(),
        "status": "received",
      };
      if (model != null) {
        params['promo_code'] = model!.promo_code.toString();
        params['promo_discount'] =
        proDiscount.toString() != null ? proDiscount.toString() : "";
      }
      print(" @@ order placed using wallet ${baseUrl}place_order");
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "place_order"), params);
      print("respnse is ## ${response.entries}");

      setState(() {
        saveStatusGold = true;
      });
      if (!response['error']) {
        setState(() {
          isDetailsSHiw = true;
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatusGold = true;
      });
    }
  }

/*
  Widget walletAmountDispatch() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Topup wallet",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Container(
          margin: EdgeInsets.all(15),
          child: TextFormField(
            controller: choiceAmountController,
            style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              focusColor: Colors.white,
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.grey,
              hintText: "₹ Enter Amount",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              labelText: '₹ Enter Amount',
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            var a = double.parse(choiceAmountController.text.toString()) * 100;
            RazorPayHelper razorHelper = new RazorPayHelper(
                a.toString(),
                context,
                (result) {},
                "curUserId",
                "resultGram.toString()",
                false,
                false);
            razorHelper.init(true, amount: a.toString(), addAmointTr: true);
          },
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffF1D459), Color(0xffB27E29)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              height: 45,
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  "PROCEED TO TOPUP",
                  style: TextStyle(color: colors.white1, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
*/

  bool isDetailsSHiw = false;

  orderWithWaleet(){
    double amountPass = double.parse(choiceAmountController.text);
    double taotlaAmount = double.parse(totalAmount.toString());
    double amountPasValue = ( taotlaAmount - amountPass);
    print("wallet !!");
    var a = amountPasValue * 100;
    print(a);
    RazorPayHelper razorHelper = new RazorPayHelper(
        totalAmount.toString(), context, (result) {
          Future.delayed(Duration(
              seconds: 3
          ),(){
            addOrderGold(amountPasValue);
          });
      if (result == "success") {
        addOrderGold(amountPasValue);
        setState(() {
          saveStatus = true;
        });
      }
          // Future.delayed(Duration(
          //     seconds: 3
          // ),(){
          //   addOrderGold(amountPasValue);
          // });
    }, App.localStorage.getString("userId").toString(),
        widget.gramValue.toString(), false, true,isWalletUset: true);
    razorHelper.initiated(true, amount: a.toString());
    Future.delayed(Duration(
      seconds: 3
    ),(){
      addOrderGold(amountPasValue);
    });
  }

  // priceView() {
  //   double amountPass = double.parse(choiceAmountController.text);
  //   double taotlaAmount = double.parse(widget.total.toString());
  //   double amountPasValue = ( taotlaAmount - amountPass);
  //   return Container(
  //     width: getWidth1(624),
  //     decoration: boxDecoration(
  //       radius: 15,
  //       bgColor: MyColorName.colorTextFour.withOpacity(0.3),
  //     ),
  //     padding: EdgeInsets.symmetric(
  //         horizontal: getWidth1(29), vertical: getHeight1(32)),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Product Total Amount",
  //               fontSize: 10.sp,
  //               fontFamily: fontRegular,
  //             ),
  //             text(
  //               "₹ ${widget.total.toString()}",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         ),
  //         boxHeight(22),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Wallet Amount used ",
  //               fontSize: 10.sp,
  //               fontFamily: fontRegular,
  //             ),
  //             text(
  //               "₹ ${choiceAmountController.text}",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         ),
  //         boxHeight(22),
  //         Divider(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Remaining Total",
  //               fontSize: 12.sp,
  //               fontFamily: fontBold,
  //             ),
  //             text(
  //               "₹$amountPasValue",
  //               fontSize: 12.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
///
  // orderWithWaleet(){
  //   double amountPass = double.parse(choiceAmountController.text);
  //   double taotlaAmount = double.parse(totalAmount.toString());
  //     //  widget.total.toString());
  //    amountPasValue = ( taotlaAmount - amountPass);
  //
  //   var a = amountPasValue * 100;
  //   RazorPayHelper razorHelper = new RazorPayHelper(
  //       amountPasValue.toString(),
  //      // widget.total.toString(),
  //
  //       context, (result) {
  //         print("%% init $result");
  //         addOrderGold(amountPasValue);
  //     if (result == "error") {
  //       setState(() {
  //         saveStatus = true;
  //       });
  //       addOrderGold(amountPasValue);
  //     }
  //   }, App.localStorage.getString("userId").toString(),
  //       widget.gramValue.toString(), false, true,isWalletUset: true);
  //   razorHelper.init(true, amount: a.toString());
  // }



}
