import 'dart:convert';
import 'dart:math';

import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Helper/Session.dart';
import '../Helper/order _Confirmed.dart';
import '../Helper/transation_mode.dart';
import '../Model/addAmountModel.dart';
import '../Model/pruchaseModel.dart';
import '../bottom_navigation.dart';


String razorPayKey="rzp_test_CpvP0qcfS4CSJD";
    //"rzp_test_UUBtmcArqOLqIY";
String razorPaySecret="rzp_test_CzVEZjetT2HvfwMDkMfaO6Oq1JD1BpiWuQseSX";
    //"NTW3MUbXOtcwUrz5a4YCshqk";
class RazorPayHelper{
  String amount;
  String? orderId;
  final BuildContext context;
  ValueChanged onResult;
  String userid;
  String gramValue;
  bool isGold;
  Razorpay? _razorpay;
  bool addAmoint = false;
  bool? isWalletUset ;
  bool isOrderProduct;
  RazorPayHelper(
      this.amount,
     @required this.context, this.onResult,this.userid, this.gramValue,
  this.isGold, this.isOrderProduct, {this.isWalletUset} );
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  init(isOrderProduct,{amount, addAmointTr}){
    addAmoint = addAmointTr;
    CircularProgressIndicator(color:colors.secondary2,);
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if(isOrderProduct){
      openCheckoutOrder(isAmooubnt: amount,addAMoun: addAmointTr);
    }else {
      openCheckout();
    }
  }
  initiated(isOrderProduct,{amount, addAmointTr}){
    addAmoint = addAmointTr;
    CircularProgressIndicator(color:colors.secondary2,);
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess1);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if(isOrderProduct){
      openCheckoutOrder(isAmooubnt: amount,addAMoun: addAmointTr);
    }else {
      openCheckout();
    }
  }



  void getOrder(amount) async {
    String username = razorPayKey;
    String password = razorPaySecret;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    double newmoney = double.parse(amount.toString());

    int nw=newmoney.toInt();
    print("nw---$nw");
    Map data = {
      "amount": nw.toString(),
      "currency": "INR",
      "receipt": "receipt_" + getRandomString(5)
    }; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: <String, String>{'authorization': basicAuth}, body: data);
    print(res.body);
    if (res.statusCode == 200) {
      Map data2 = json.decode(res.body);
      orderId = data2['id'];

    }
    else {
      print(res.body);
      print(res.statusCode);
    }
  }

  void openCheckout() async {
    await App.init();
    var options = {
      'key': razorPayKey,
      'amount': amount,
      'name': 'Sanghavi Gold',
      "order_id": orderId,
      'description': "Order #"+getRandomString(5),
      'external': {
        'wallets': ['paytm']
      },
      'prefill': {
        'name': name,
        'contact': App.localStorage.getString("phone"),
      },
      "notify": {
        "sms": true,
        "email": true
      },
      "reminder_enable": true,
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void openCheckoutOrder({isAmooubnt, addAMoun}) async {
    await App.init();
    var options = {
      'key': razorPayKey,
      'amount': isAmooubnt  ,
      'name': 'Attica Gold',
      "order_id": orderId,
      'description': "Order #"+getRandomString(5),
      'external': {
        'wallets': ['paytm']
      },
      'prefill': {
        'name': name,
        'contact': App.localStorage.getString("phone"),
      },
      "notify": {
        "sms": true,
        "email": true
      },
      "reminder_enable": true,
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    double amm = double.parse(amount.toString())/100;
        if(gramValue != null && gramValue.toString().length > 1
           ){
        PruchaseModel? a =  await purchaseGold(userid, amm.toString(),
            gramValue, isGold, context);
        if(a != null && a.message != null ){
          Fluttertoast.showToast(
              backgroundColor: colors.secondary2,
              fontSize: 18, textColor: colors.blackTemp,
              msg: "Order confirm");
          navigateScreen(context, OrderConfirmed());
        }
      }else{
        AddAmountModel? a = await addAmountBalance(
            amount: amount,
            orderId: response.paymentId,
            status: "success",
            tranxId: response.paymentId,
            userId: App.localStorage.getString("userId"));
        if(a != null && a.message != null ){
          Fluttertoast.showToast(
              backgroundColor: colors.secondary2,
              fontSize: 18, textColor: colors.blackTemp,
              msg: "Amount added successfully");
        }
    }

    // }
  }

  void _handlePaymentSuccess1(PaymentSuccessResponse response) async {
    // if(isWalletUset != null && isWalletUset!){
      onResult("success");
      navigateScreen(context, OrderConfirmed());
    // }else{
    //   if(!isOrderProduct && gramValue != null && gramValue.toString().length > 1
    //       && addAmoint == null ){
    // if(gramValue != null && gramValue.toString().length > 1){
    //   PruchaseModel? a =  await purchaseGold(userid, amount,
    //       gramValue, isGold, context);
    //   if(a != null && a.message != null ){
    //     Fluttertoast.showToast(
    //         backgroundColor: colors.secondary2,
    //         fontSize: 18, textColor: colors.blackTemp,
    //         msg: "Order confirm");
    //     navigateScreen(context, OrderConfirmed());
    //   }
    // }else{
    //   AddAmountModel? a = await addAmountBalance(
    //       amount: amount,
    //       orderId: response.paymentId,
    //       status: "success",
    //       tranxId: response.paymentId,
    //       userId: App.localStorage.getString("userId"));
    //   if(a != null && a.message != null ){
    //     Fluttertoast.showToast(
    //         backgroundColor: colors.secondary2,
    //         fontSize: 18, textColor: colors.blackTemp,
    //         msg: "Amount added successfully");
    //   }
    // }
    // }
  }

  Future<AddAmountModel?> addAmountBalance({String? userId, String? amount, String? orderId,String? status,
    String? tranxId, }) async {
    var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
    var request =
    http.MultipartRequest('POST', Uri.parse(baseUrl + 'add_transaction'));
    //double amo = double.parse(amount.toString())/100;
    request.fields.addAll({
      "transaction_type": "wallet",
      "user_id": App.localStorage.getString("userId").toString(),
      "order_id": "$orderId",
      "type": "debit",
      "payment_method": "razorpay",
      "txn_id": "$tranxId",
      "amount": "$amount",
      "status": "$status",
      "message": "Done",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Navigator.pop(context);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return AddAmountModel.fromJson(json.decode(str));
    } else {
      return AddAmountModel(message: "Something went wrong");
    }
  }


  void _handlePaymentError(PaymentFailureResponse response) {
    setSnackbar("Payment Cancelled", context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    onResult(response.walletName);
    }
}