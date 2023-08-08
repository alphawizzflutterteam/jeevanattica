import 'package:atticadesign/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/myCart.dart';
import 'Helper/sellSilverModel.dart';
import 'Model/UserDetailsModel.dart';
import 'Utils/Common.dart';

class SellDigitalGold extends StatefulWidget {
  String goldRate;
  String gold1Rate;
   SellDigitalGold({
    required this.goldRate,required this.gold1Rate,Key? key}) : super(key: key);

  @override
  State<SellDigitalGold> createState() => _SellDigitalGoldState();
}

class _SellDigitalGoldState extends State<SellDigitalGold> {
  final choiceAmountController = TextEditingController();
  final choiceAmountControllerGram = TextEditingController();

  bool isBuyNow = true;

  double resultGram = 0.0;
  double taotalPrice = 0.00;
  double goldenWallet = 0.00,
      totalBalance = 0.00;
      // silverGram = 62.00,
      // goldGram = 5246.96;
  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  double goldRate = 0.00, silverRate = 0.00;
  TextStyle kTextStyle = TextStyle(
      fontSize: 14.0,

      color: Color(0xfffafcfb));
  double min = 0, max = 100;
  RangeValues rangeValues = RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
    goldRate = double.parse(widget.goldRate.toString());
    silverRate = double.parse(widget.gold1Rate.toString());
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double goldWallet = 0.00, silverWallet = 0.00;
  bool isGold = true;

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
        goldWallet =
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

  // void getWallet() async {
  //   userDetailsModel =
  //       await userDetails(App.localStorage.getString("userId").toString());
  //   if (userDetailsModel != null &&
  //       userDetailsModel.data![0].goldWallet != null) {
  //     setState(() {
  //       double balance =
  //           double.parse(userDetailsModel.data![0].goldWallet.toString());
  //       goldWallet = balance / goldRate;
  //     });
  //   }if( userDetailsModel != null &&userDetailsModel.data![0].silverWallet != null) {
  //     setState(() {
  //       double balance =
  //       double.parse(userDetailsModel.data![0].silverWallet.toString());
  //       silverWallet = balance / silverRate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white1,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xFF15654F),
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
          "Sell Digital ${isGold ? "Gold-916": "Gold-999"} ",
          style: TextStyle(color: colors.blackTemp),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCart()));
            },
            child: Image.asset(
              "assets/images/shop.png",
              height: 20,
              width: 20,
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 1.1,
          ),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0, left: 15.0),
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: isGold ? Colors.green : Colors.grey,
                              border: Border.all(
                                  color:
                                  isGold ? Colors.green : Colors.black12),
                              borderRadius:
                              BorderRadius.all(Radius.circular(7.0) //
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
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
                                        color: isGold
                                            ? Colors.white
                                            : Color(0xff0C3B2E),
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
                              color: !isGold ? Colors.green : Colors.grey,
                              border: Border.all(
                                  color:
                                  !isGold ? Colors.green : Colors.black12),
                              borderRadius:
                              BorderRadius.all(Radius.circular(7.0) //
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                setState(() {
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
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Gold-999',
                                      style: TextStyle(
                                        color: !isGold
                                            ? Colors.white
                                            : Color(0xff0C3B2E),
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 230,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: colors.primaryNew,
                      image: DecorationImage(
                        image: AssetImage("assets/onboarding/sellDidital.png"),
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
                              'Start selling \ndigital ${isGold ? "gold-916" : "gold-999"}\nnow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
          //             Row(
          //               children: [
          //                 Padding(
          //                   padding: const EdgeInsets.only(left: 10.0),
          //                   child: Text(
          //                     '₹',
          //                     style: TextStyle(
          //                       color:colors.secondary2,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 10,
          //                     ),
          //                   ),
          //                 ),
          // //                 Row(
          // //                   mainAxisAlignment: MainAxisAlignment.center,
          // //                   children: [Text(
          // //                     '${isGold ? goldRate : silverRate} /gm',
          // //                     style: TextStyle(
          // //                       color:colors.secondary2,
          // //                       fontWeight: FontWeight.bold,
          // //                       fontSize: 10,
          // //                     ),
          // //                   ),
          // // ]
          // //                 )
          //               ],
          //             ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Current selling price',
                              style: TextStyle(
                                color: colors.white1,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            ': ₹ ${isGold ? goldRate : silverRate} /gm',
                            style: TextStyle(
                              color:colors.white1,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 50),
                          //   child: Text(
                          //     'Price Valid For',
                          //     style: TextStyle(
                          //       color: Color(0xffffffff),
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 10,
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 5.0),
                          //   child: Text(
                          //     '02:44',
                          //     style: TextStyle(
                          //       color:colors.secondary2,
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 10,
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How much you want to Pledge?',
                        style: TextStyle(
                          color: colors.blackTemp,
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
                            style: TextStyle(
                              fontSize: 12,
                                fontWeight: FontWeight.w500),)),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.all(10),
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
                                resultGram = int.parse(value) / reate;
                                choiceAmountControllerGram.text =
                                    resultGram.toStringAsFixed(6).toString();
                              } else {
                                choiceAmountControllerGram.clear();
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
                    SizedBox(
                      child: Icon(Icons.compare_arrows,
                          color: colors.blackTemp, size: 35),
                      width: 35,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.all(10),
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
                            resultGram =  double.parse(value);
                            if (value.isNotEmpty) {
                              choiceAmountController.text =
                                  taotalPrice.toStringAsFixed(2);
                            }
                            else {
                              taotalPrice = 0.00;
                              choiceAmountController.clear() ;
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
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                    color: colors.secondary2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Total Available Gram :',
                          style: TextStyle(
                            color: colors.blackTemp,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        '${isGold ? availeGoldgram.toStringAsFixed(2).toString()
                            : availebaleSilveGram.toStringAsFixed(2).toString() } gms',
                        style: TextStyle(
                          color: colors.blackTemp,
                          //Color(0xffF1D459),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    //if (isBuyNow) {
                    //   setState(() {
                    //     isBuyNow = false;
                    //   });
                      String iserId =
                          App.localStorage.getString("userId").toString();
                      SellSilverGoldModel a = await sellGoldOrSilver(
                          iserId,
                          resultGram,
                          choiceAmountController.text,
                          isGold,
                          context);
                      if (a != null && a.message != null) {
                        showDialog(
                          context: context,
                          builder: (ctxt) => new AlertDialog(
                            title: Text("${a.message}"),
                            actions: [
                              GestureDetector(
                                child: Center(child: Text("Okay")),
                                onTap: () {
                                  choiceAmountController.clear();
                                  choiceAmountControllerGram.clear();
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      }
                   // }
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(colors: [
                         colors.secondary2,
                          Color(0xffB27E29),
                        ])),
                    child: Center(
                      child: Text(
                        'SELL NOW ₹ ${choiceAmountController.text.toString()}',
                        style: TextStyle(
                          color: Color(0xff0F261E),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
