import 'package:atticadesign/Helper/wallettopup.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/selldigitalgold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Api/api.dart';
import '../Model/UserDetailsModel.dart';
import '../Provider/live_price_provider.dart';
import '../Utils/Common.dart';
import '../Utils/withdrawmodel.dart';
import '../screen/delivery_goldOrSilver.dart';
import '../screen/sell_digil-silver-onlye.dart';
import '../screen/with_draw_page.dart';
import 'Color.dart';

class MyLocker extends StatefulWidget {
  const MyLocker({Key? key}) : super(key: key);

  @override
  State<MyLocker> createState() => _MyLockerState();
}

class _MyLockerState extends State<MyLocker> {

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double silverWallet = 0.00,
      goldenWallet = 0.00,
      totalBalance = 0.00;
  double availeGoldgram = 0.00, availebaleSilveGram = 0.00;
  TextEditingController amountWithDerrwa = TextEditingController();
  TextEditingController choiceAmountController = TextEditingController();

  void getWallet() async {
    var livePrice = Provider.of<LivePriceProvider>(context);
    userDetailsModel =
        await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].silverWallet != null &&
        userDetailsModel.data![0].silverWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].silverWallet.toString());
        availebaleSilveGram =
            double.parse(userDetailsModel.data![0].silverWallet.toString());
        // silverWallet =
        //     double.parse(userDetailsModel.data![0].silverWallet.toString()) *
        //         silverGram;
        silverWallet = double.parse(livePrice.gold2.toString()) * double.parse(userDetailsModel.data![0].silverWallet.toString());
      });
    }
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null &&
        userDetailsModel.data![0].goldWallet != "") {
      setState(() {
        print(userDetailsModel.data![0].goldWallet.toString());
        availeGoldgram =
            double.parse(userDetailsModel.data![0].goldWallet.toString());
        // goldenWallet =
        //     double.parse(userDetailsModel.data![0].goldWallet.toString()) *
        //         goldGram;
        goldenWallet = double.parse(livePrice.gold1.toString()) * double.parse(userDetailsModel.data![0].goldWallet.toString());
        print("this is gold wallet ## ${goldenWallet.toString()}");
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
  @override
  void initState() {
    super.initState();
    getWallet();
    // goldGram = double.parse(widget.goldRate.toString());
    // silverGram = double.parse(widget.gold1Rate.toString());
  }

  @override
  Widget build(BuildContext context) {
    getWallet();
    var livePrice = Provider.of<LivePriceProvider>(context);
    return Scaffold(
      //backgroundColor: Color(0xFF0F261E),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Available Cash Balance",
                    style: TextStyle(color: colors.blackTemp, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ ${totalBalance.toStringAsFixed(2)}",
                    style: TextStyle(color: colors.blackTemp, fontSize: 20),
                  ),
                ],
              ),
              height: 120,
              width: 280,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/lockerback.png"),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletTopups()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffF1D459), Color(0xffB27E29)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        height: 40,

                        child: Center(
                          child: Text(
                            "ADD AMOUNT",
                            style: TextStyle(
                                color: colors.white1, fontSize: 15),
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
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WithDrawPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xffF1D459), Color(0xffB27E29)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        height: 40,

                        child: Center(
                          child: Text(
                            "WITHDRAW AMOUNT",
                            style: TextStyle(
                                color: colors.white1, fontSize: 15),
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
            height: 10,
          ),

          SizedBox(
            height: 10,
          ),
          Card(
            color: colors.secondary2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8, right: 12),
                              child: Text(
                                "Gold-916 Balance : ",
                                maxLines: 2,
                                style: TextStyle(
                                    color: colors.blackTemp, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  // availeGoldgram != 0.0 ?
                                  " ${availeGoldgram.toStringAsFixed(4).toString()} grm" ,
                                  // \n(₹ ${goldenWallet.toStringAsFixed(2).toString()})"
                                  // :" ${availeGoldgram.toStringAsFixed(4).toString()} grm \n(₹ 0.00)",
                                  style: TextStyle(
                                      color: colors.blackTemp, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8, right: 12),
                              child: Text(
                                "Gold-999 Balance : ",
                                maxLines: 2,
                                style: TextStyle(
                                    color: colors.blackTemp, fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  // availebaleSilveGram !=0.00 ?
                                  "${availebaleSilveGram.toStringAsFixed(4).toString()} grm ",
                                  //     "\n(₹ ${silverWallet.toStringAsFixed(2).toString()})"
                                  // :   "${availebaleSilveGram.toStringAsFixed(4).toString()} grm "
                                  //     "\n(₹ 0.00)",
                                  style: TextStyle(
                                      color: colors.blackTemp, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/lockerback.png"),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellDigitalGold(
                                      goldRate: livePrice.gold1.toString(),
                                      gold1Rate: livePrice.gold2.toString(),
                                    )),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colors.black54,
                                      colors.blackTemp,],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              height: 40,
                              child: Center(
                                child: Text(
                                  "Sell ",
                                  style: TextStyle(
                                      color: colors.secondary2, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddNewAddressDelivery(
                                            typeGoldOrSilver: true,
                                          goldGrams: availeGoldgram.toStringAsFixed(2),
                                          silverGrams: availebaleSilveGram.toStringAsFixed(2),
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [ colors.black54,
                                      colors.blackTemp,],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              height: 40,

                              child: Center(
                                child: Text(
                                  "Delivery ",
                                  style: TextStyle(
                                      color: colors.secondary2, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
               /* Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 4),
                              width: 150,
                              child: Text(
                                "Silver balance",
                                maxLines: 2,
                                style: TextStyle(
                                    color:colors.secondary2, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                "₹ ${silverWallet.toStringAsFixed(2).toString()} (${availebaleSilveGram.toStringAsFixed(2).toString()} grm)",
                                style: TextStyle(
                                    color:colors.secondary2, fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),


                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 30, right: 10),
                      //       child: RichText(
                      //         text: TextSpan(
                      //           style: TextStyle(
                      //               color: Colors.black, fontSize: 12),
                      //           children: <TextSpan>[
                      //             TextSpan(
                      //                 text: 'Buy More',
                      //                 style: TextStyle(
                      //                     decoration: TextDecoration.underline,
                      //                     color: Color(0xff98C924)))
                      //           ],
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                  height: 120,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/lockerback.png"),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SellDigitalSilverOnlye()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                     colors.secondary2,
                                      Color(0xffB27E29)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              height: 40,

                              child: Center(
                                child: Text(
                                  "Sell Silver",
                                  style: TextStyle(
                                      color: colors.white1, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      Expanded(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddNewAddressDelivery(typeGOldOrSilver: false,)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xffF1D459), Color(0xffB27E29)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              height: 40,

                              child: Center(
                                child: Text(
                                  "Delivery Silver",
                                  style: TextStyle(
                                      color: colors.white1, fontSize: 15),
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
                ),*/
                // Center(
                //   child: Container(
                //     decoration: BoxDecoration(
                //         gradient: LinearGradient(
                //           colors: [Color(0xffF1D459), Color(0xffB27E29)],
                //           begin: Alignment.topCenter,
                //           end: Alignment.bottomCenter,
                //         ),
                //         borderRadius: BorderRadius.circular(30.0)),
                //     height: 35,
                //     width: 160,
                //     child: Center(
                //       child: Text(
                //         "DELIVER TO ME",
                //         style:
                //             TextStyle(color: colors.white1, fontSize: 15),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
          // ListTile(
          //   leading: Text(
          //     "Recent Transaction History",
          //     style: TextStyle(color: Colors.white, fontSize: 17),
          //   ),
          //   trailing: InkWell(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => Transaction()),
          //         );
          //       },
          //       child: Text(
          //         "View All",
          //         style: TextStyle(color:colors.secondary2, fontSize: 17),
          //       )),
          // ),
          // FutureBuilder(
          //     future: getTransation(App.localStorage.getString("userId").toString()),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       if (snapshot.hasData && snapshot.data != null) {
          //         TransactionModel? transationModel = snapshot.data;
          //         return transationModel!.data!.isNotEmpty
          //             ? ListView.builder(
          //             shrinkWrap: true,
          //             physics: ClampingScrollPhysics(),
          //             itemCount: transationModel.data!.length > 3 ? 4 : transationModel.data!.length,
          //             itemBuilder: (context, index){
          //               return  Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Card(
          //                   color: colors.primaryNew,
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10.0),
          //                   ),
          //                   child: ListTile(
          //                     leading: Image.asset(
          //                         "assets/images/lockercupan.png"),
          //                     title: Padding(
          //                       padding: const EdgeInsets.symmetric(vertical: 6),
          //                       child: Text(
          //                         "${transationModel.data![0].purchaseType}",
          //                         style: TextStyle(
          //                             color: Colors.white, fontSize: 18),
          //                       ),
          //                     ),
          //
          //                     subtitle: Padding(
          //                       padding: const EdgeInsets.symmetric(vertical: 12),
          //                       child: RichText(
          //                         text: TextSpan(
          //                           style: TextStyle(
          //                               color: Colors.black,
          //                               fontSize: 17),
          //                           children: <TextSpan>[
          //                             TextSpan(
          //                                 text:
          //                                 "${transationModel.data![0].createdAt}",
          //                                 style: TextStyle(
          //                                     color: Colors.white54)),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                     trailing: Text(
          //                       "₹ ${transationModel.data![0].amount}",
          //                       style: TextStyle(
          //                           color:colors.secondary2,
          //                           fontSize: 20),
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             }
          //         )
          //             : Center(child: Text("No Transaction Available"));
          //       } else if (snapshot.hasError) {
          //         return Icon(Icons.error_outline);
          //       } else {
          //         return Container(
          //             height: 50,
          //             width: 50,
          //             child: CircularProgressIndicator(
          //               strokeWidth: 1,
          //             ));
          //       }
          //     })

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: colors.primaryNew,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/addition.png"),
          //       title: Text(
          //         "Added To wallet",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 12",
          //         style: TextStyle(color:colors.secondary2, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: colors.primaryNew,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/lockeruser.png"),
          //       title: Text(
          //         "Referral Money",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 30",
          //         style: TextStyle(color:colors.secondary2, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Card(
          //     color: colors.primaryNew,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //     child: ListTile(
          //       leading: Image.asset("assets/images/lockeruser.png"),
          //       title: Text(
          //         "Referral Money",
          //         style: TextStyle(color: Colors.white, fontSize: 18),
          //       ),
          //       subtitle: RichText(
          //         text: TextSpan(
          //           style: TextStyle(color: Colors.black, fontSize: 17),
          //           children: <TextSpan>[
          //             TextSpan(
          //                 text: '05 July 2021',
          //                 style: TextStyle(color: Colors.white54)),
          //             TextSpan(
          //                 text: '   02:12',
          //                 style: TextStyle(color: Colors.white54)),
          //           ],
          //         ),
          //       ),
          //       trailing: Text(
          //         "₹ 30",
          //         style: TextStyle(color:colors.secondary2, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
