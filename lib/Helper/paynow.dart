import 'dart:async';
import 'dart:convert';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/order%20_Confirmed.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Razorpay.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Api/api.dart';
import '../Model/UserDetailsModel.dart';
import '../Utils/widget.dart';
import 'Color.dart';

class PayNow extends StatefulWidget {
  double? discount, total, subTotal, proDiscount;
  VoucherModel? model;
  String gramValue;
  String? time = "", des, deliveryCharge;
  String deliveryStatus;
  bool isGold;

  PayNow(
      this.discount,
      this.total,
      this.model,
      this.time,
      this.des,
      this.subTotal,
      this.deliveryStatus,
      this.deliveryCharge,
      this.gramValue,
      this.isGold);

  @override
  State<PayNow> createState() => _PayNowState();
}

class _PayNowState extends State<PayNow> {
  String taxAmount = "0", taxPer = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
    getWallet();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15654F),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
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
          "Pay Now",
          style: TextStyle(color: Colors.white54),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              boxHeight(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        /* addOrder();*/
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Gold balance",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color:colors.secondary2, fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    "₹ ${goldenWallet.toStringAsFixed(2).toString()} \n( ${availeGoldgram.toStringAsFixed(2).toString()} grm)",
                                    style: TextStyle(
                                        color:colors.secondary2, fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 4),
                                    width: 150,
                                    child: Text(
                                      "Silver balance",
                                      maxLines: 2,
                                      style: TextStyle(
                                          color:colors.secondary2,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      "₹ ${silverWallet.toStringAsFixed(2).toString()} \n(${availebaleSilveGram.toStringAsFixed(2).toString()} grm)",
                                      style: TextStyle(
                                          color:colors.secondary2,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/lockerback.png"),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    if (isWaleetUser)
                      Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: choiceAmountController,
                          onFieldSubmitted: (value){

                            addOrderGold();
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
                            prefixIcon: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.grey,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "₹ Enter Amount Used to Wallet",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            labelText: '₹ Enter Amount Used to Wallet',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if(isDetailsSHiw)
                priceView(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child:
               InkWell(
                onTap: () {
                  var a = double.parse(widget.total.toString()) * 100;
                  RazorPayHelper razorHelper = new RazorPayHelper(
                      widget.total.toString(), context, (result) {
                    if (result == "error") {
                      setState(() {
                        saveStatus = true;
                      });
                    } else {
                      addOrder();
                    }
                  }, App.localStorage.getString("userId").toString(),
                      widget.gramValue.toString(), false, true);
                  razorHelper.init(true, amount: a.toString());
                },
                child: Container(
                  height: getHeight1(80),
                  width: getWidth1(400),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.0),
                      gradient: LinearGradient(
                        colors: [Color(0xffF1D459), Color(0xffB27E29)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: saveStatus
                        ? Text(
                      "PAYMENT Razor Pay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colors.white1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                        : CircularProgressIndicator(
                      color: MyColorName.colorTextFour,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 1,
              child: isDetailsSHiw ? InkWell(
                onTap: () {
                  orderWithWaleet();
                },
                child: Container(
                  height: getHeight1(80),
                  width: getWidth1(400),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.0),
                      gradient: LinearGradient(
                        colors: [Color(0xffF1D459), Color(0xffB27E29)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: saveStatus
                        ? Text(
                      "PAYMENT Wallet Pay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colors.white1,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                        : CircularProgressIndicator(
                      color: MyColorName.colorTextFour,
                    ),
                  ),
                ),
              ) : InkWell(
                onTap: () {
                  setState(() {
                    isWaleetUser = true;
                  });
                },
                child: Container(
                  height: getHeight1(80),
                  width: getWidth1(400),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23.0),
                      gradient: LinearGradient(
                        colors: [Color(0xffF1D459), Color(0xffB27E29)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: saveStatusGold
                        ? Text(
                            "PAYMENT Wallet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colors.white1,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(
                            color: MyColorName.colorTextFour,
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool walletStatus = false;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int? currentIndex;
  List<CartModel> cartList = [];
  List<String> productId = [];
  List<String> quantity = [];
  bool saveStatus = true, saveStatusSilve = true, saveStatusGold = true;
  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00,
      goldenWallet = 0.00,
      totalBalance = 0.00,
      silverGram = 52.00,
      goldGram = 5246.96;
  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  TextEditingController amountWithDerrwa = TextEditingController();

  void getWallet() async {
    userDetailsModel =
        await userDetails(App.localStorage.getString("userId").toString());
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
        for (var v in response['data']) {
          setState(() {
            productId.add(v['product_variant_id']);
            quantity.add(v['qty']);
            taxAmount = response['tax_amount'];
            taxPer = response['tax_percentage'];
          });
        }
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


  TextEditingController choiceAmountController = TextEditingController();

  bool isWaleetUser = false;
  String totalAmount = "";

  addOrderGold() async {
    App.init();
    try {
      setState(() {
        saveStatusGold = false;
      });
      print("ok");
      double amount = 0;
      print(amount);
      Map params = {
        "place_order": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "mobile": App.localStorage.getString("phone").toString(),
        "order_note":
            widget.des.toString() != "" ? widget.des.toString() : "No Note",
        "product_variant_id":
            productId.toString().replaceAll("[", "").replaceAll("]", ""),
        "quantity": quantity.toString().replaceAll("[", "").replaceAll("]", ""),
        "total": widget.subTotal.toString(),
        "delivery_charge": widget.deliveryCharge,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "tax_amount": taxAmount.toString(),
        "tax_percentage": taxPer.toString(),
        "wallet_balance": "0",
        "is_wallet_used": "0",
        "booking_order1": "0",
        "goldwallet_used": "1",
        "silver_wallet_used": "",
        "wallet_balance_used": "0",
        "address_id": addressId.toString(),
        "final_total": choiceAmountController.text.toString(),
        "pro_discount": widget.proDiscount.toString(),
        "payment_method": "Razorpay",
        "delivery_time": widget.time.toString() == ""
            ? "Express Delivery"
            : jsonEncode(widget.time).toString(),
        "accesskey": "90336".toString(),
        "status": "received",
      };
      if (widget.model != null) {
        params['promo_code'] = widget.model!.promo_code.toString();
        params['promo_discount'] =
            widget.discount != null ? widget.discount.toString() : "";
      }
      print(baseUrl + "place_order");
      Map response =
          await apiBase.postAPICall(Uri.parse(baseUrl + "place_order"), params);

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
  priceView() {
    double amountPass = double.parse(choiceAmountController.text);
    double taotlaAmount = double.parse(widget.total.toString());
    double amountPasValue = ( taotlaAmount - amountPass);
    return Container(
      width: getWidth1(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(29), vertical: getHeight1(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Product Total Amount",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹ ${widget.total.toString()}",
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
                "Wallet Amount used ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹ ${choiceAmountController.text}",
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
                "Remaining Total",
                fontSize: 12.sp,
                fontFamily: fontBold,
              ),
              text(
                "₹$amountPasValue",
                fontSize: 12.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  orderWithWaleet(){
    double amountPass = double.parse(choiceAmountController.text);
    double taotlaAmount = double.parse(widget.total.toString());
    double amountPasValue = ( taotlaAmount - amountPass);

    var a = amountPasValue * 100;
    RazorPayHelper razorHelper = new RazorPayHelper(
        widget.total.toString(), context, (result) {
      if (result == "error") {
        setState(() {
          saveStatus = true;
        });
      }
    }, App.localStorage.getString("userId").toString(),
        widget.gramValue.toString(), false, true,isWalletUset: true);
    razorHelper.init(true, amount: a.toString());
  }

  addOrder() async {
    App.init();
    try {
      setState(() {
        saveStatus = false;
      });
      print("ok");
      double amount = 0;
      print(amount);
      Map params = {
        "place_order": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "mobile": App.localStorage.getString("phone").toString(),
        "order_note":
            widget.des.toString() != "" ? widget.des.toString() : "No Note",
        "product_variant_id":
            productId.toString().replaceAll("[", "").replaceAll("]", ""),
        "quantity": quantity.toString().replaceAll("[", "").replaceAll("]", ""),
        "total": widget.subTotal.toString(),
        "delivery_charge": widget.deliveryCharge,
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        "tax_amount": taxAmount.toString(),
        "tax_percentage": taxPer.toString(),
        "wallet_balance": "0",
        "is_wallet_used": "0",
        "booking_order1": "0",
        "goldwallet_used": "0",
        "silver_wallet_used": "0",
        "wallet_balance_used": "0",
        "address_id": addressId.toString(),
        "final_total": widget.total.toString(),
        "pro_discount": widget.proDiscount.toString(),
        "payment_method": "Razorpay",
        "delivery_time": widget.time.toString() == ""
            ? "Express Delivery"
            : jsonEncode(widget.time).toString(),
        "accesskey": "90336".toString(),
        "status": "received",
      };
      if (widget.model != null) {
        params['promo_code'] = widget.model!.promo_code.toString();
        params['promo_discount'] =
            widget.discount != null ? widget.discount.toString() : "";
      }
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
}
