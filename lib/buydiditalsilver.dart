import 'dart:async';

import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/notifications.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/Session.dart';
import 'Model/UserDetailsModel.dart';
import 'Model/voucher_model.dart';
import 'Utils/ApiBaseHelper.dart';
import 'Utils/Common.dart';
import 'Utils/Razorpay.dart';
import 'Utils/colors.dart';
import 'Utils/constant.dart';
import 'Utils/widget.dart';
import 'buydigitalgold.dart';

class BuyDigitalSilver extends StatefulWidget {
  const BuyDigitalSilver({Key? key}) : super(key: key);

  @override
  State<BuyDigitalSilver> createState() => _BuyDigitalSilverState();
}

class _BuyDigitalSilverState extends State<BuyDigitalSilver> {
  List categories = ['₹10', '₹20', '₹50', '₹100'];
  List selectedCategories = [];
  var selected = '';
  TextEditingController choiceAmountController = TextEditingController();
  TextEditingController choiceAmountControllerGram = TextEditingController();
  double taotalPrice = 0.00;

  double resultGram = 0.00;
  bool isGold = true;
  double silverRate = 63;

  @override
  void initState() {
    super.initState();
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00;

  void getWallet() async {
    userDetailsModel =
    await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].silverWallet != null && userDetailsModel.data![0].silverWallet != "") {
      setState(() {
        print( userDetailsModel.data![0].silverWallet.toString());
        silverWallet = double.parse(userDetailsModel.data![0].silverWallet.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xff15654F),
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
          "Buy Digital Silver",
          style: TextStyle(
            color: colors.black54,
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
                      MaterialPageRoute(builder: (context) => NotiPage()),
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
                        MaterialPageRoute(builder: (context) => MyCart()),
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
        scrollDirection: Axis.vertical,
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/homepage/vertical.png',
                ),
                fit: BoxFit.cover,
              )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 15.0),
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            colors.secondary2,
                            Color(0xffB27E29),
                          ]),
                          // color: Color(0xff#F1D459),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BuyDigitalGold()),
                            );
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
                                  'Gold',
                                  style: TextStyle(
                                    color: Color(0xff0C3B2E),
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
                        width: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xffE2E2E2),
                            Color(0xff717171),
                          ]),
                          // color: Color(0xff#F1D459),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/homepage/silverbrick.png',
                                height: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Silver',
                                style: TextStyle(
                                  color: Color(0xff0C3B2E),
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 250,
                width: 335,
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: colors.primaryNew,
                    image: DecorationImage(
                      image: AssetImage("assets/homepage/silver.png"),
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
                            'Start Buying \ndigital Silver \nNow',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10.0),
                    //       child: Text(
                    //         '₹ ${silverWallet.toStringAsFixed(2).toString()}',
                    //         style: TextStyle(
                    //           color:colors.secondary2,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     ),
                    //     Text(
                    //       '$silverRate/gm',
                    //       style: TextStyle(
                    //         color:colors.secondary2,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 10,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 10.0),
                    //       child: Text(
                    //         'Current buying price',
                    //         style: TextStyle(
                    //           color: Color(0xffffffff),
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 40,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 50),
                    //       child: Text(
                    //         'Price Valid For',
                    //         style: TextStyle(
                    //           color: Color(0xffffffff),
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 5.0),
                    //       child: Text(
                    //         '02:44',
                    //         style: TextStyle(
                    //           color:colors.secondary2,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 10,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // )
                    Text(
                      'Total Silver Wallet ₹ ${silverWallet.toStringAsFixed(2).toString()}',
                      style: TextStyle(
                        color:colors.secondary2,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 130.0, top: 12.0),
                child: Text(
                  'How much you want to buy?',
                  style: TextStyle(
                    color: colors.black54.withOpacity(1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //       "Silver Wallet Amount ${silverWallet.toString()}"),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              ///
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: choiceAmountController,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                          onFieldSubmitted: (value) {
                            resultGram = int.parse(value) / silverRate;
                            if(value.isNotEmpty){
                              //isGold = true;
                              choiceAmountControllerGram.text = "";
                              choiceAmountControllerGram.clear();
                            }
                            // else{
                            //   isGold = false;
                            // }
                            setState(() {});
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: choiceAmountControllerGram,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                          onFieldSubmitted: (value) {
                            if(value.isNotEmpty){
                              choiceAmountController.text = "";
                              choiceAmountController.clear();
                              isGold = false;
                              taotalPrice = int.parse(value) * silverRate;
                            }else{
                              taotalPrice =0.00;
                              isGold = true;
                            }
                            setState(() {});
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
                  ),
                ],
              ),
              ///

              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: colors.primaryNew,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    isGold ? 'Gram ${resultGram.toStringAsFixed(2)}' :"Price ${taotalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Color(0xffE2E2E2),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              /*  Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25))),
                              side: BorderSide(
                                  width: 1, color: Color(0xff0C3B2E)),
                              backgroundColor: Color(0xff15654F),
                              label: Text('1000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              selected: choiceAmountController == '1000',
                              onSelected: (bool selected) {
                                setState(() {
                                  choiceAmountController.text =
                                      (selected ? '1000' : '');
                                  print("10::---$choiceAmountController");
                                  resultGram =
                                      int.parse(choiceAmountController.text) /
                                          silverRate;
                                });
                              },
                              selectedColor: Color(0xff699a8d),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25))),
                              // ShapeBorder avatarBorder = const CircleBorder(),
                              //   avatarBorder:const CircleBorder(),
                              side: BorderSide(
                                  width: 1, color: Color(0xff0C3B2E)),
                              backgroundColor: Color(0xff15654F),
                              label: Text('2000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          colors.black54.withOpacity(0.5),
                                      fontSize: 20)),
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              // selected: choice== 'right',
                              selected: choiceAmountController == '2000',
                              onSelected: (bool selected) {
                                setState(() {
                                  print("20::");
                                  choiceAmountController.text =
                                      (selected ? '2000' : '');
                                  resultGram =
                                      int.parse(choiceAmountController.text) /
                                          silverRate;
                                });
                              },
                              selectedColor: Color(0xff699a8d),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25))),
                              side: BorderSide(
                                  width: 1, color: Color(0xff0C3B2E)),
                              backgroundColor: Color(0xff15654F),
                              label: Text('5000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          colors.black54.withOpacity(0.5),
                                      fontSize: 20)),
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              selected: choiceAmountController == '5000',
                              onSelected: (bool selected) {
                                setState(() {
                                  print("50::");
                                  choiceAmountController.text =
                                      (selected ? '5000' : '');
                                  resultGram =
                                      int.parse(choiceAmountController.text) /
                                          silverRate;
                                });
                              },
                              selectedColor: Color(0xff699a8d),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25),
                                      right: Radius.circular(25))),
                              side: BorderSide(
                                  width: 1, color: Color(0xff0C3B2E)),
                              backgroundColor: Color(0xff15654F),
                              label: Text('10000',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          colors.black54.withOpacity(0.5),
                                      fontSize: 20)),
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              selected: choiceAmountController == '10000',
                              onSelected: (bool selected) {
                                setState(() {
                                  print("100::");
                                  choiceAmountController.text =
                                      (selected ? '10000' : '');
                                  resultGram =
                                      int.parse(choiceAmountController.text) /
                                          silverRate;
                                });
                              },
                              selectedColor: Color(0xff699a8d),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),*/
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 120.0),
                child: Text(
                  'You can Buy up to 1000 per day',
                  style: TextStyle(
                    color: Color(0xffE2E2E2),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              voucherView(),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Center(child: LinearProgressIndicator());
                  var curUserId = App.localStorage.getString("userId").toString();
                  int as = int.parse(choiceAmountController.text);
                  int a = as * 100;

                  RazorPayHelper razorHelper=new RazorPayHelper(a.toString(), context, (result){
                    if(result=="error"){
                      setState(() {});
                    }
                  }, curUserId, resultGram.toString(), false, false);
                  razorHelper.init(false);
                },
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                        colors.secondary2,
                        Color(0xffB27E29),
                      ])),
                  child: Center(
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(
                        color: Color(0xff0F261E),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
  ApiBaseHelper apiBase = new ApiBaseHelper();
  voucherView() {
    return Container(
      height: getHeight1(144),
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
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
                addVoucher(choiceAmountController.text, result.promo_code, result);
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
  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id":App.localStorage.getString("userId").toString(),
        "final_total": choiceAmountController.text.toString(),
        "promo_code": promoCode.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          choiceAmountController.text = response['data'][0]['final_total'].toString() ;
        });
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
      });
    }
  }
  double? voucher;
  VoucherModel? model;
}
