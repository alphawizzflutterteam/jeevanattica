import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/screen/newVerifyMPin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/kYC.dart';
import '../Helper/myCart.dart';
import '../Helper/order _Confirmed.dart';
import '../Provider/live_price_provider.dart';
import '../Utils/ApiBaseHelper.dart';
import '../Utils/Razorpay.dart';
import '../Utils/colors.dart';
import '../Utils/constant.dart';
import '../Utils/widget.dart';
import '../notifications.dart';
import '../screen/verify-mpin-screen.dart';
import '../transaction.dart';
import 'UserDetailsModel.dart';

class ScanTransaction extends StatefulWidget {
  String? goldRate;
  String? gold1Rate;
   ScanTransaction({
    this.goldRate,
    this.gold1Rate,
     Key? key}) : super(key: key);

  @override
  State<ScanTransaction> createState() => _ScanTransactionState();
}

class _ScanTransactionState extends State<ScanTransaction> {

  TextEditingController choiceAmountController = TextEditingController();
  TextEditingController choiceAmountControllerGram = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();
  TextEditingController mpinController = TextEditingController();

  double resultGram = 0.00 ;
  double taotalPrice = 0.00;
  bool isGold = true;
  double goldRate = 5262.96;
  double silverRate = 63;
  bool isBuyNow = true;
  Razorpay? _razorpay;
  double taxPer = 3;
  double taxAmount = 0;
  double totalAmount = 0 ,
      restAmount= 0 ;
  // String razorPayKey = "rzp_test_UUBtmcArqOLqIY";
  // String razorPaySecret = "NTW3MUbXOtcwUrz5a4YCshqk";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    getWallet();
    goldRate = double.parse(widget.goldRate.toString());
    silverRate = double.parse(widget.gold1Rate.toString());
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00,
      goldenWallet = 0.00,
      totalBalance = 0.00;
  double balance =0.00;
  bool isWallet = false;
  bool isGoldWallet = false;
  bool isSilverWallet = false;

  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  ApiBaseHelper apiBase = new ApiBaseHelper();

  doPayment(){
    double as = double.parse("${totalAmount.toString()}") ;
    double a = as * 100;
    choiceAmountController.clear();
    choiceAmountControllerGram.clear();
    RazorPayHelper razorHelper =
    new RazorPayHelper(a.toString(), context, (result) {
      if (result == "error") {
        setState(() {});
      }
    }, App.localStorage.getString("userId").toString(), resultGram.toString(), isGold, false);
    razorHelper.init(false);
  }

  String walletType= "";
  bool isMpin = false;
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
                double.parse(widget.gold1Rate.toString());
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
                double.parse(widget.goldRate.toString());
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

  addOrder() async {
    App.init();
    try {
      double amount = 0;
      print(amount);
      Map params = {
        "user_id": App.localStorage.getString("userId").toString(),
        "type": "${walletType.toString()}",
        "amount": "${choiceAmountController.text.toString()}",
        "value": choiceAmountControllerGram.text.toString()
      };
      print("@@ this is param ${params.toString()}");


      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "scan_pay"), params);

      if (!response['error']) {
        navigateScreen(context, OrderConfirmed());
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);

    }
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
                  walletType = "1";
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
          // isGold == true?
          Container(
            height: 50,
            child: CheckboxListTile(
              title: Text("Gold-916 Wallet : ${availeGoldgram.toStringAsFixed(2)} grm"
              ),
              value: isGoldWallet,
              activeColor: colors.secondary2,
              checkColor: colors.blackTemp,
              onChanged: (value) {
                setState(() {
                  walletType = "2";
                  isGoldWallet = value!;
                  isWallet = false;
                  isSilverWallet = false;
                  // _roomController.text = '${item.id}';
                  // print('${_roomController.text}');
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
              // : SizedBox(),
         // isGold == false ?
          Container(
            height: 50,
            child: CheckboxListTile(
              title: Text("Gold-999 Wallet : ${availebaleSilveGram.toStringAsFixed(2)} grm"
              ),
              value: isSilverWallet,
              activeColor: colors.secondary2,
              checkColor: colors.blackTemp,
              onChanged: (value) {
                setState(() {
                  walletType = "3";
                  isSilverWallet = value!;
                  isWallet = false;
                  isGoldWallet = false;
                  // _roomController.text = '${item.id}';
                  // print('${_roomController.text}');
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
              // : SizedBox(),
          // isWallet || isGoldWallet || isSilverWallet?
          // Container(
          //   margin: EdgeInsets.all(15),
          //   child: TextFormField(
          //     controller: walletAmountController,
          //     onFieldSubmitted: (value){
          //       // if (curIndex == null) {
          //       //   setSnackbar("Please Select or Add Address", context);
          //       //   return;
          //       // }
          //       restAmount = totalAmount - double.parse(walletAmountController.text);
          //       // addOrderGold(amountPasValue);
          //
          //     },
          //     autofocus: true,
          //     style: TextStyle(
          //       fontSize: 24,
          //       color: Colors.blue,
          //       fontWeight: FontWeight.w600,
          //     ),
          //     keyboardType: TextInputType.number,
          //     decoration: InputDecoration(
          //       focusColor: Colors.white,
          //       // prefixIcon: Icon(
          //       //   Icons.person_outline_rounded,
          //       //   color: Colors.grey,
          //       // ),
          //
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide: const BorderSide(
          //             color: Colors.blue, width: 1.0),
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       fillColor: Colors.grey,
          //       hintText: "₹ Enter amount used from Wallet",
          //       hintStyle: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w400,
          //       ),
          //       labelText: '₹ Enter amount used from Wallet',
          //       labelStyle: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w400,
          //       ),
          //     ),
          //   ),
          // )
          //     : SizedBox.shrink(),
          // Container(
          //   height: 50,
          //   child: CheckboxListTile(
          //     title: Text("RazorPay"),
          //     value: isRazor,
          //     activeColor: colors.secondary2,
          //     checkColor: colors.blackTemp,
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

  @override
  Widget build(BuildContext context) {
    var livePrice = Provider.of<LivePriceProvider>(context);
    getWallet();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
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
          //isGold ?
          "Scan and Pay" ,
              //:  "Buy Digital Silver" ,
          style: TextStyle(
            color: colors.blackTemp,
            fontSize: 20,
          ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyCart()),
                    );
                  },
                  child: Icon(Icons.shopping_cart_rounded,
                      color:colors.secondary2)),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotiPage()),
                      );
                    },
                    child: Icon(Icons.notifications_active,
                        color:colors.secondary2)),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   height: 250,
              //   width: double.infinity,
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   padding: EdgeInsets.only(top: 12, left: 8, right: 8),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(30)),
              //       color: colors.primaryNew,
              //       image: DecorationImage(
              //         image:   AssetImage(
              //           //isGold ?
              //             "assets/homepage/coinback.png"
              //         ),
              //         //: "assets/homepage/silver.png") ,
              //       )),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(
              //                 bottom: 100.0, left: 20, top: 20),
              //             child: Text(
              //               'Start buying \ndigital ${isGold ? "Gold-916" : "Gold-999"} \nnow',
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 20,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Text(
              //         'Total ${isGold ? "Gold-916" : "Gold-999"} Wallet : '
              //             '${isGold && goldenWallet > 1 ?
              //         "${availeGoldgram.toStringAsFixed(2)} gms \n(₹ ${goldenWallet.toStringAsFixed(2).toString()})"
              //             :
              //         silverWallet > 1 ? "${availebaleSilveGram.toStringAsFixed(2)} gms \n(₹ ${silverWallet.toStringAsFixed(2).toString()})"
              //             : "0.00 gms \n(₹ 0.00)"}',
              //         style: TextStyle(
              //           color:colors.white1,
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),


              SizedBox(
                height: 15,
              ),
              Text(
                'Please Select any wallet',
                style: TextStyle(
                  color: colors.black54.withOpacity(1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: Container(
              //         margin: EdgeInsets.all(15),
              //         child: TextFormField(
              //           controller: choiceAmountController,
              //           style: TextStyle(
              //             fontSize: 24,
              //             color: Colors.blue,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           onChanged: (value){
              //             double abcs =  isGold ? goldRate :silverRate;
              //             if(value.isNotEmpty){
              //               resultGram = int.parse(value) / abcs;
              //               isGold = true;
              //               choiceAmountControllerGram.text = resultGram.toStringAsFixed(2).toString();
              //             }else{
              //               choiceAmountControllerGram.clear();
              //               isGold = false;
              //             }
              //             setState(() {});
              //           },
              //       /*    onFieldSubmitted: (value) {
              //             double abcs =  isGold ? goldRate :silverRate;
              //             resultGram = int.parse(value) / abcs;
              //             if(value.isNotEmpty){
              //               isGold = true;
              //               choiceAmountControllerGram.text = resultGram.toStringAsFixed(2).toString();
              //             }else{
              //               isGold = false;
              //             }
              //             setState(() {});
              //           },*/
              //
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(
              //             focusColor: Colors.white,
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                   color: Colors.blue, width: 1.0),
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //             fillColor: Colors.grey,
              //             hintText: "₹ Amount",
              //             hintStyle: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //             ),
              //
              //             labelText: '₹ Enter Amount',
              //             labelStyle: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       child: Icon(Icons.compare_arrows, color: Colors.white, size: 35),
              //       width: 35,
              //     ),
              //     Expanded(
              //       flex: 1,
              //       child: Container(
              //         margin: EdgeInsets.all(15),
              //         child: TextFormField(
              //           controller: choiceAmountControllerGram,
              //           style: TextStyle(
              //             fontSize: 24,
              //             color: Colors.blue,
              //             fontWeight: FontWeight.w600,
              //           ),
              //           onChanged: (value){
              //             if(value.isNotEmpty){
              //               double abc= isGold ? goldRate : silverRate;
              //               taotalPrice = int.parse(value) * abc;
              //               choiceAmountController.text = taotalPrice.toStringAsFixed(2).toString();
              //               isGold = false;
              //             }else{
              //               taotalPrice =0.00;
              //               isGold = true;
              //               choiceAmountController.clear();
              //             }
              //             setState(() {});
              //           },
              //           keyboardType: TextInputType.number,
              //           decoration: InputDecoration(
              //             focusColor: Colors.white,
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //             focusedBorder: OutlineInputBorder(
              //               borderSide: const BorderSide(
              //                   color: Colors.blue, width: 1.0),
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //             fillColor: Colors.grey,
              //             hintText: "Gram",
              //             hintStyle: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //             ),
              //
              //             labelText: 'Enter Gram',
              //             labelStyle: TextStyle(
              //               color: Colors.grey,
              //               fontSize: 16,
              //               fontWeight: FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10),
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 120.0),
              //     child: Text(
              //       'You can Buy up to 1000 per day',
              //       style: TextStyle(
              //         color: colors.blackTemp,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),

             // voucherView(),
              SizedBox(
                height: 15,
              ),
              paymentMode(),

              isWallet == true &&  isGoldWallet == false || isSilverWallet == false ?
              Padding(
                padding: const EdgeInsets.only(
                    left: 10,right: 10,
                    top: 20,
                bottom: 20),
                child: Container(
                  height: 50,
                  margin: EdgeInsets.all(12),
                  child: TextFormField(
                    controller: choiceAmountController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        var reate = isGold ? goldRate : silverRate;
                        resultGram = double.parse(value) / reate;
                        choiceAmountControllerGram.text =
                            resultGram.toStringAsFixed(6).toString();

                        // taxAmount = (double.parse(value)* (taxPer/100));
                        // totalAmount = double.parse(value) + taxAmount;
                        totalAmount =  double.parse(value);
                        // if(voucher != null){
                        //   totalAmount = totalAmount - double.parse(voucher!.toStringAsFixed(2));
                        // }
                      } else {
                        choiceAmountControllerGram.clear();
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.grey,
                      hintText: "₹ Amount",
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
              )
              : SizedBox.shrink(),
              isGoldWallet == true || isSilverWallet == true ? Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: choiceAmountController,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              var reate = isGold ? goldRate : silverRate;
                              resultGram = double.parse(value) / reate;
                              choiceAmountControllerGram.text =
                                  resultGram.toStringAsFixed(6).toString();

                              // taxAmount = (double.parse(value)* (taxPer/100));
                              // totalAmount = double.parse(value) + taxAmount;
                              totalAmount =  double.parse(value);
                              // if(voucher != null){
                              //   totalAmount = totalAmount - double.parse(voucher!.toStringAsFixed(2));
                              // }
                            } else {
                              choiceAmountControllerGram.clear();
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            hintText: "₹ Amount",
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
                    ),
                  ),
                  Icon(Icons.compare_arrows,
                      color: colors.blackTemp, size: 30),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(8),
                      child: TextFormField(
                        controller: choiceAmountControllerGram,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                        // onChanged: (value) {
                        //   double a = isGold ? goldRate : silverRate;
                        //   taotalPrice = double.parse(value) * a;
                        //
                        //   if (value.isNotEmpty) {
                        //     choiceAmountController.text =
                        //         taotalPrice.toStringAsFixed(2).toString();
                        //     resultGram = double.parse(choiceAmountControllerGram.text.toString());
                        //     //taxAmount = (taotalPrice* (taxPer/100));
                        //     totalAmount = taotalPrice ;
                        //     //+ taxAmount;
                        //   } else {
                        //     taotalPrice = 0.00;
                        //     choiceAmountController.clear() ;
                        //   }
                        //   setState(() {});
                        // },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.grey,
                          hintText: "Gram",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          labelText: 'Enter Gram',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : SizedBox.shrink(),
             //  choiceAmountController.text.isNotEmpty ?
             // buySummary()
             //      : SizedBox(),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()async{
                var result =  await Navigator.push(context, MaterialPageRoute(builder: (context) => NewVerifyMPINScreen()));
                if(result == true){
                  addOrder();
                }
                else if( result == null || result == ""){

                }
                 // addOrder();


                  //  print("walletType @@ ${walletType.toString()}");
                  // var a = double.parse(totalAmount.toString()) * 100;
                  // RazorPayHelper razorHelper = new RazorPayHelper(
                  //     totalAmount.toString(), context, (result) {
                  //   addOrder();
                  //   if (result == "error") {
                  //
                  //   } else {
                  //     addOrder();
                  //   }
                  // }, App.localStorage.getString("userId").toString(),
                  //     choiceAmountControllerGram.text.toString(), false, true);
                  // razorHelper.init(true, amount: a.toString());
                  // addOrder();
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        isBuyNow ? colors.secondary2 : Colors.grey,
                        isBuyNow ? Color(0xffB27E29) : Colors.black12,
                      ])),
                  child: Center(
                    child: Text(
                      'PAY NOW',
                          //'₹ ${totalAmount.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      ),
    );

  }
}

