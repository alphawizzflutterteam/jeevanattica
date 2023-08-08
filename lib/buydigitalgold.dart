import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:atticadesign/Helper/Color.dart';
import 'package:atticadesign/Helper/kYC.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/screen/paymentScreen.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:atticadesign/splash.dart';
import 'package:atticadesign/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:toggle_switch/toggle_switch.dart';
import 'Api/api.dart';
import 'Helper/Session.dart';
import 'Helper/myCart.dart';
import 'Model/UserDetailsModel.dart';
import 'Model/voucher_model.dart';
import 'Provider/live_price_provider.dart';
import 'Utils/ApiBaseHelper.dart';
import 'Utils/Common.dart';
import 'Utils/Razorpay.dart';
import 'Utils/colors.dart';
import 'Utils/widget.dart';
import 'buydiditalsilver.dart';
import 'notifications.dart';

class BuyDigitalGold extends StatefulWidget {
  String? goldRate;
  String? gold1Rate;
  BuyDigitalGold({
    this.goldRate,
    this.gold1Rate,
    Key? key}) : super(key: key);

  @override
  State<BuyDigitalGold> createState() => _BuyDigitalGoldState();
}

class _BuyDigitalGoldState extends State<BuyDigitalGold> {
  List categories = ['₹10', '₹20', '₹50', '₹100'];
  List selectedCategories = [];
  var selected = '';
  TextEditingController choiceAmountController = TextEditingController();
  TextEditingController choiceAmountControllerGram = TextEditingController();
  TextEditingController walletAmountController = TextEditingController();

  double resultGram = 0.00 ;
  double taotalPrice = 0.00;
  bool isGold = true;
  double goldRate = 5262.96;
  double silverRate = 63;
  bool isBuyNow = true;
  Razorpay? _razorpay;
  double taxPer = 3;
  double taxAmount = 0;
  double totalAmount = 0 ;
  // String razorPayKey = "rzp_test_CpvP0qcfS4CSJD";
  // String razorPaySecret = "rzp_test_CzVEZjetT2HvfwMDkMfaO6Oq1JD1BpiWuQseSX";
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String? _dropDownValue;
  List lista = [
    '999 Gold',
    '916 Gold',
  ];

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  TextStyle header = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  TextStyle value = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );



  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
    _razorpay = Razorpay();
    getWallet();
    goldRate = double.parse(widget.goldRate.toString());
    silverRate = double.parse(widget.gold1Rate.toString());
  }


  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "setu1104540890799539623@kaypay",
      receiverName: 'sesfs',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return Center(child: CircularProgressIndicator());
    else if (apps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Wrap(
            children: apps!.map<Widget>((UpiApp app) {
              return GestureDetector(
                onTap: () {
                  _transaction = initiateTransaction(app);
                  setState(() {});
                },
                child: Container(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.memory(
                        app.icon,
                        height: 60,
                        width: 60,
                      ),
                      Text(app.name),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
  }


  late WebViewController webViewController;

  var paymentLink;

  Future<void>setupApi()async{
    // print("sssssssssssssss ${amt}");
    // int finalPayment = amt * 100;
    print("checking  final payment");
    var headers = {
      'Cookie': 'ci_session=8a0c2eb916e1d7d7efbd763b1950c0168a951214'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}get_payment_links'));
    request.fields.addAll({
      'amount': '100',
    });
    print("checking params here1111 ${request.fields} and ${baseUrl}get_payment_links");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("final response here ${jsonResponse}");
      setState(() {
        paymentLink = jsonResponse['data']['paymentLink']['upiLink'];
      });
      print("ooooooooooo ${paymentLink}");

   //   String url = 'upi://pay?pa=nareshlocal@kaypay&pn=Setu%20Payment%20Links%20Test&am=200.00&tr=875621444531258946&tn=Payment%20for%20918147077472&cu=INR&mode=04';
      // var dd  = html.window.open(paymentLink.toString(), "new tab");
      // print("oookook ${dd}");

      // UpiPayment upiPayment = new UpiPayment('100', context, (value) {
      //   if(value.status==UpiTransactionStatus.success){
      //     Navigator.pop(context);
      //     print("payment status here ");
      //     //placeOrder('',upiResponse: value);
      //   }else{
      //     Fluttertoast.showToast(msg: "Payment Failed");
      //   }
      // });
      // upiPayment.initPayment();
      print("checking launch here ${canLaunchUrl(paymentLink)}");
      if(await canLaunch(paymentLink)){
        print("checking link here ${paymentLink}");
        await launch(paymentLink,forceWebView: false);
      }else {
        throw 'Could not launch $paymentLink';
      }
      print("checking upi link here ${paymentLink}");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00,
      goldenWallet = 0.00,
      totalBalance = 0.00;

  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;

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
                silverRate;
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
                goldRate;
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

  String payMethod = 'razorPay';

var balance = 0.0;
  bool isWallet = false;
  bool isGoldWallet = false;
  bool isSilverWallet = false;
  double  restAmount= 0;

  // priceView() {
  //   return Container(
  //     width: getWidth1(624),
  //     decoration: boxDecoration(
  //       radius: 15,
  //       bgColor: colors.secondary2.withOpacity(0.3),
  //     ),
  //     padding: EdgeInsets.symmetric(
  //         horizontal: getWidth1(29), vertical: getHeight1(32)),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Total MRP",
  //               fontSize: 10.sp,
  //               fontFamily: fontSemibold,
  //             ),
  //             text(
  //               "₹$totalAmount",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         ),
  //         boxHeight(12),
  //
  //         voucher != null ? boxHeight(12) : SizedBox(),
  //         voucher != null
  //             ? Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Voucher Discount",
  //               fontSize: 10.sp,
  //               fontFamily: fontRegular,
  //             ),
  //             text(
  //               "-₹$voucher",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         )
  //             : SizedBox(),
  //
  //
  //         boxHeight(proDiscount > 0 ? 12 : 0),
  //         proDiscount > 0
  //             ? Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Pro Discount",
  //               fontSize: 10.sp,
  //               fontFamily: fontRegular,
  //             ),
  //             text(
  //               "-₹$proDiscount",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         )
  //             : SizedBox(),
  //
  //         boxHeight(12),
  //         // Row(
  //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         //   children: [
  //         //     text(
  //         //       "Tax",
  //         //       fontSize: 10.sp,
  //         //       fontFamily: fontRegular,
  //         //     ),
  //         //     text(
  //         //       "₹${tax}",
  //         //       fontSize: 10.sp,
  //         //       fontFamily: fontBold,
  //         //     ),
  //         //   ],
  //         // ),
  //         isWallet || isGoldWallet || isSilverWallet ?
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Wallet Amount Used",
  //               fontSize: 10.sp,
  //               fontFamily: fontSemibold,
  //             ),
  //             text(
  //               "-₹${choiceAmountController.text}",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         )
  //             : SizedBox(height: 0,),
  //         Divider(),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             text(
  //               "Total Amount",
  //               fontSize: 10.sp,
  //               fontFamily: fontSemibold,
  //             ),
  //
  //             text(
  //               choiceAmountController.text.isNotEmpty ?
  //               "₹ $restAmount"
  //                   : "₹ $totalAmount",
  //               fontSize: 10.sp,
  //               fontFamily: fontBold,
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
              title: Text("Wallet : ₹ ${totalBalance.toStringAsFixed(2)}"),
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
          isGold == true?
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
          isGold == false ?
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
          isWallet ?
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              controller: walletAmountController,
              onFieldSubmitted: (value){
                // if (curIndex == null) {
                //   setSnackbar("Please Select or Add Address", context);
                //   return;
                // }
                restAmount = totalAmount - double.parse(walletAmountController.text);
                // addOrderGold(amountPasValue);
                print("rest amount here and total amount here as well ${restAmount} and ${totalAmount}");
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

  @override
  Widget build(BuildContext context) {
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
          isGold ? "Buy Digital Gold" :  "Buy Digital Silver" ,
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
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Container(
                            height: 50,
                            //  width: 150,
                            decoration: BoxDecoration(
                              color: isGold
                                  ? Colors.green
                                  : Colors.grey,
                              border: Border.all(
                                  color: isGold
                                      ? Colors.green
                                      : Colors.black12),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(7.0) //
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isBuyNow = true;
                                  isGold = !isGold;
                                  choiceAmountControllerGram.clear();
                                  choiceAmountController.clear();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/homepage/gold.png',
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Gold-916',
                                      style: TextStyle(
                                        color: isGold ? Colors.white :Color(0xff0C3B2E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 15),
                          child: Container(
                            height: 50,
                            // width: 150,
                            decoration: BoxDecoration(
                              color: !isGold
                                  ? Colors.green
                                  : Colors.grey,
                              border: Border.all(
                                  color: !isGold
                                      ? Colors.green
                                      : Colors.black12),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(7.0) //
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isBuyNow = true;
                                  isGold = !isGold;
                                  choiceAmountControllerGram.clear();
                                  choiceAmountController.clear();
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/homepage/gold.png',
                                      // 'assets/homepage/silverbrick.png',
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Gold-999',
                                      style: TextStyle(
                                        color: !isGold ? Colors.white : Color(0xff0C3B2E),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // isGold?
                // Padding(
                //   padding: const EdgeInsets.only(top: 12.0, left: 15),
                //   child: Container(
                //    // height: 60,
                //     width: 180,
                //     decoration:
                //     BoxDecoration(
                //       color: colors.secondary2.withOpacity(0.4),
                //         borderRadius: BorderRadius.circular(20.0)),
                //     child:
                //     DropdownButton<String>(
                //         value: _dropDownValue,
                //         isExpanded: true,
                //         underline: Container(
                //           height: 1.0,
                //           decoration: const BoxDecoration(),
                //           child: Text(
                //             'Choose Gold Type',
                //             style: TextStyle(
                //               color: colors.blackTemp,
                //               fontSize: 15,
                //             ),
                //           ),
                //         ),
                //         dropdownColor: colors.secondary2.withOpacity(0.8),
                //         hint: _dropDownValue == null
                //             ? Padding(
                //           padding:
                //           const EdgeInsets.only(left: 10.0),
                //           child: Text(
                //             'Choose Gold Type',
                //             style: TextStyle(
                //               color: colors.blackTemp,
                //               fontSize: 15,
                //               fontWeight: FontWeight.bold
                //             ),
                //           ),
                //         )
                //             : Text(
                //           _dropDownValue!,
                //           style: TextStyle(color: colors.blackTemp),
                //         ),
                //         iconSize: 40.0,
                //         iconEnabledColor: colors.blackTemp,
                //         style: TextStyle(color: colors.blackTemp),
                //         items: lista.map(
                //               (val) {
                //             return DropdownMenuItem<String>(
                //               value: val,
                //               child: val != null ? Text(val) : Text("Select ID"),
                //             );
                //           },
                //         ).toList(),
                //         onChanged: (val) {
                //           setState(
                //                 () {
                //               _dropDownValue = val as String?;
                //             },
                //           );
                //         }),
                //   ),
                // )
                // : SizedBox(height: 0,),
              ],
            ),

            SizedBox(
              height: 15,
            ),
            Container(
              height: 250,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.only(top: 12, left: 8, right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: colors.primaryNew,
                  image: DecorationImage(
                    image:   AssetImage(
                      //isGold ?
                        "assets/homepage/coinback.png"
                    ),
                    //: "assets/homepage/silver.png") ,
                  )),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 100.0, left: 20, top: 20),
                        child: Text(
                          'Start buying \ndigital ${isGold ? "Gold-916" : "Gold-999"} \nnow',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Total ${isGold ? "Gold-916" : "Gold-999"} Wallet : '
                        '${isGold && goldenWallet > 1 ?
                    "${availeGoldgram.toStringAsFixed(2)} gms \n(₹ ${goldenWallet.toStringAsFixed(2).toString()})"
                        :
                    silverWallet > 1 ? "${availebaleSilveGram.toStringAsFixed(2)} gms \n(₹ ${silverWallet.toStringAsFixed(2).toString()})"
                        : "0.00 gms \n(₹ 0.00)"}',
                    style: TextStyle(
                      color:colors.white1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How much you want to buy?',
                    style: TextStyle(
                      color: colors.black54.withOpacity(1),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Transaction()));
                    },
                    child: Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffF1D459).withOpacity(0.8), Color(0xffB27E29).withOpacity(0.8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      child: Center(child: Text("View Transactions",
                        style: TextStyle(fontWeight: FontWeight.w500),)),
                    ),
                  ),
                ],
              ),
            ),


            Row(
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
                            taxAmount = (double.parse(value)* (taxPer/100));
                            totalAmount = double.parse(value) + taxAmount;
                            print("checing amount controller ${totalAmount}");
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

                      onChanged: (value) {
                        double a = isGold ? goldRate : silverRate;
                        taotalPrice = double.parse(value) * a;

                        if (value.isNotEmpty) {

                          choiceAmountController.text =
                              taotalPrice.toStringAsFixed(2).toString();
                          resultGram = double.parse(choiceAmountControllerGram.text.toString());
                          taxAmount = (taotalPrice* (taxPer/100));
                          totalAmount = taotalPrice + taxAmount;
                          print("this is total 1234 $totalAmount");
                        } else {
                          taotalPrice = 0.00;
                          choiceAmountController.clear() ;
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

            SizedBox(
              height: 10,
            ),
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
            //
            // voucherView(),
            SizedBox(
              height: 10,
            ),
            paymentMode(),

            choiceAmountController.text.isNotEmpty ?
            buySummary()
                : SizedBox(),

/// select payment option

      choiceAmountController.text.isEmpty ? SizedBox.shrink() : Container(
           margin: EdgeInsets.only(top: 10),
           child: Column(
             children: [
               SizedBox(height: 20,),
               Text("Select payment method",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),),
               RadioListTile(
                 title: Text("RazorPay"),
                 value: "razorPay",
                 groupValue: payMethod,
                 onChanged: (value){
                   setState(() {
                     payMethod = value.toString();
                   });
                   print("paymethod here ${payMethod}");
                 },
               ),

               RadioListTile(
                 title: Text("Setu"),
                 value: "setu",
                 groupValue: payMethod,
                 onChanged: (value){
                   setState(() {
                     payMethod = value.toString();
                   });

                   print("paymethod here ${payMethod}");
                 },
               ),

               // Container(
               //   child: Row(
               //     children: [
               //       Container(
               //         child: Cont,
               //       ),
               //
               //     ],
               //   ),
               // )
             ],
           ),
         ),


           payMethod == "razorPay" ? GestureDetector(
              onTap: (){
                if(totalAmount > 100000) {
                  showDialog(
                      context: context,
                      // barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: colors.secondary2,
                          title: Text("KYC",
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                          content: Text("You need to update KYC to buy digital gold worth more than 1 Lacs",
                            style: TextStyle(
                                fontSize: 14
                            ),),

                          actions: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                      colors: [
                                        colors.black54,
                                        colors.blackTemp,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Center(
                                    child: Text(
                                      "No",
                                      style: TextStyle(color: colors.secondary2),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () async{
                                var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));
                                // Navigator.pop(context);
                                if(result == true){
                                  Navigator.pop(context);
                                  doPayment();
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                      colors: [
                                        colors.black54,
                                        colors.blackTemp,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Center(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: colors.secondary2),
                                    )),
                              ),
                            ),
                          ],
                        );
                      });
                }else{
                  if (choiceAmountController.text.isNotEmpty) {
                    if (choiceAmountController.text.isNotEmpty
                        || resultGram.toString().isNotEmpty
                        || choiceAmountControllerGram.text.isNotEmpty) {
                      doPayment();
                    }
                  }else{
                    Fluttertoast.showToast(msg: "Please Enter amount or grams!!");
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
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
                    'BUY NOW',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ) :
           GestureDetector(
             onTap: ()async{
               print("setu api here");
               if(totalAmount > 100000) {
                 showDialog(
                     context: context,
                     // barrierDismissible: false,
                     builder: (BuildContext context) {
                       return AlertDialog(
                         backgroundColor: colors.secondary2,
                         title: Text("KYC",
                           style: TextStyle(
                               fontWeight: FontWeight.bold
                           ),),
                         content: Text("You need to update KYC to buy digital gold worth more than 1 Lacs",
                           style: TextStyle(
                               fontSize: 14
                           ),),

                         actions: <Widget>[
                           InkWell(
                             onTap: () {
                               Navigator.pop(context);
                             },
                             child: Container(
                               height: 40,
                               width: 100,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20.0),
                                 gradient: LinearGradient(
                                     colors: [
                                       colors.black54,
                                       colors.blackTemp,
                                     ],
                                     begin: Alignment.topCenter,
                                     end: Alignment.bottomCenter),
                               ),
                               child: Center(
                                   child: Text(
                                     "No",
                                     style: TextStyle(color: colors.secondary2),
                                   )),
                             ),
                           ),
                           InkWell(
                             onTap: () async{
                               var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>KYC()));
                               // Navigator.pop(context);
                               if(result == true){
                                 Navigator.pop(context);
                               //  doPayment();
                               }
                             },
                             child: Container(
                               height: 40,
                               width: 100,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20.0),
                                 gradient: LinearGradient(
                                     colors: [
                                       colors.black54,
                                       colors.blackTemp,
                                     ],
                                     begin: Alignment.topCenter,
                                     end: Alignment.bottomCenter),
                               ),
                               child: Center(
                                   child: Text(
                                     "Yes",
                                     style: TextStyle(color: colors.secondary2),
                                   )),
                             ),
                           ),
                         ],
                       );
                     });
               }else{
                 setupApi();
                 // if (choiceAmountController.text.isNotEmpty) {
                 //   if (choiceAmountController.text.isNotEmpty
                 //       || resultGram.toString().isNotEmpty
                 //       || choiceAmountControllerGram.text.isNotEmpty) {
                 //     //doPayment();
                 //  //   setupApi(walletAmountController.text.isNotEmpty ? int.parse(restAmount.toString()) : int.parse(totalAmount.toString()));
                 //        setupApi();
                 //   }
                 // }else{
                 //   Fluttertoast.showToast(msg: "Please Enter amount or grams!!");
                 // }
               }
             },
             child:payMethod != 'razorPay' ? displayUpiApps() : Container(
               margin: EdgeInsets.only(top: 10),
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
                   'BUY NOW',
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
    );
  }

  voucherView() {
    return Container(
      height: getHeight1(144),
      width: getWidth1(622),
      decoration: boxDecoration(
          radius: 15,
          bgColor: colors.secondary2.withOpacity(0.5)
        //MyColorName.colorTextFour.withOpacity(0.3),
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

                addVoucher(
                    choiceAmountController.text, result.promo_code, result);
              }
            },
            child: Container(
              width: getWidth1(160),
              height: getHeight1(55),
              decoration:
              boxDecoration(radius: 48, bgColor: MyColorName.primaryDark),
              child: Center(
                child: text("See All",
                    fontFamily: fontMedium,
                    fontSize: 10.sp,
                    textColor: MyColorName.colorTextPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buySummary() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 15, bottom: 15),
      child: Container(
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
                    walletAmountController.text.isNotEmpty ? "₹ $totalAmount" : "₹ $totalAmount",
                  //"₹ ${choiceAmountController.text.toString()}",
                  //"₹$subTotal",
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
                  "Exclusive Tax (${taxPer.toString()}%)",
                  fontSize: 10.sp,
                  fontFamily: fontRegular,
                ),
                text( taxAmount.toString() != null ?
                "₹ ${taxAmount.toStringAsFixed(2)}":
                "₹ 0.00",
                  // "₹$tax",
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
                  "Promo Discount",
                  fontSize: 10.sp,
                  fontFamily: fontRegular,
                ),
                text(
                  "-₹$voucher",
                  //proDiscount",
                  fontSize: 10.sp,
                  fontFamily: fontBold,
                ),
              ],
            )
                : SizedBox(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text(
                  "Wallet Amount Used",
                  fontSize: 10.sp,
                  fontFamily: fontRegular,
                ),
                text(
                 walletAmountController.text.isEmpty ? "-₹ 0 " :  "-₹ ${walletAmountController.text}",
                  fontSize: 10.sp,
                  fontFamily: fontBold,
                ),
              ],
            ),
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
               walletAmountController.text.isNotEmpty ?
                       "₹ $restAmount" : "₹ $totalAmount",
                  fontSize: 10.sp,
                  fontFamily: fontBold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  doPayment(){
    double as =  walletAmountController.text.isNotEmpty ? double.parse(restAmount.toStringAsFixed(2)) : double.parse("${totalAmount.toStringAsFixed(2)}") ;
    double a = as * 100;
    choiceAmountController.clear();
    choiceAmountControllerGram.clear();
    print("this is @@ ${App.localStorage.getString("userId").toString()}, ${totalAmount.toString()} & ${resultGram.toString()}");
    RazorPayHelper razorHelper =
    new RazorPayHelper(a.toString(), context, (result) {
      if (result == "error") {
        setState(() {});
      }
    }, App.localStorage.getString("userId").toString(), resultGram.toString(), isGold, false);
    razorHelper.init(false);
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();

  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "final_total": choiceAmountController.text.toString(),
        "promo_code": promoCode.toString(),
      };
      print("gdfhfdh" + params.toString());
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      print(response.toString());

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          proDiscount =
              double.parse(response['data'][0]['final_total'].toString());
          totalAmount = totalAmount - double.parse(voucher!.toStringAsFixed(2));
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {});
    }
  }

  double? voucher;
  double proDiscount = 0;
  VoucherModel? model;
}
