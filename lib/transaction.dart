import 'dart:async';

import 'package:atticadesign/screen/cart_product_view.dart';
import 'package:flutter/material.dart';

import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/Session.dart';
import 'Helper/myCart.dart';
import 'Helper/transation_mode.dart';
import 'Model/order_model.dart';
import 'Model/transaction_model.dart';
import 'Utils/ApiBaseHelper.dart';
import 'Utils/Common.dart';
import 'Utils/colors.dart';
import 'Utils/constant.dart';
import 'Utils/widget.dart';
import 'notifications.dart';
import 'screen/order_details.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {

  bool isGold = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  int totalCount = 0;
  int? currentIndex;
  String productImage = "", productName = "";
  bool loading = true;
  bool loadingWish = false;
  String? transactionData ;
  double? grams;
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
        //backgroundColor: Color(0xff15654F),
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
            "Transaction",
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
        body:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child:  Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
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
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Transaction',
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

                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  'Order',
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
                  ],
                ),
              ),
              if(isGold)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: colors.black54.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12.0, left: 10, right: 15),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: '',
                                labelStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Icon(
                                    Icons.search,
                                    color: colors.black54,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      bottomSheet();
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/buydigitalgold/filter.png',
                          height: 20,
                          color: colors.blackTemp,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: colors.blackTemp,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if(isGold)
              SizedBox(
                height: 20,
              ),
              if(isGold)
              typeSelect == "3"
                  ? FutureBuilder(
                      future: getTransationCash(
                        App.localStorage.getString("userId").toString(),
                      ),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          TransationModeOnlyAmount? transationModel =
                              snapshot.data;
                          double amount = 0.00, tranctionData = 0.00;

                          return transationModel!.data!.length > 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: transationModel.data!.length,
                                      itemBuilder: (context, index) {
                                        if(transationModel.data![index].amount != null){
                                          amount =  double.parse(transationModel.data![index].amount.toString());
                                        }
                                        if(transationModel.data![index].credit != null){
                                          tranctionData =  double.parse(transationModel.data![index].credit.toString());
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            color: colors.secondary2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: ListTile(
                                              leading: Image.asset(
                                                  "assets/images/lockercupan.png",
                                              ),
                                              title: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 6,),
                                                  Text(
                                                    "${capitalize(transationModel.data![index].message.toString())}",
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(height: 4,),
                                                  Text(
                                                    "Cash",
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 17),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              "${transationModel.data![index].dateCreated}",
                                                          style: TextStyle(
                                                              color:colors.blackTemp,)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              trailing:Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "₹ ${amount.toStringAsFixed(2).toString()}",
                                                    style: TextStyle(
                                                        color:
                                                        colors.blackTemp,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: Center(
                                      child: Text(
                                    "No History Yet",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )));
                        }
                        else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ));
                        }
                      })
                  : FutureBuilder(
                      future: typeSelect == "1"
                          ? getTransationType(
                              App.localStorage.getString("userId").toString(),
                          typeSelect)
                          : typeSelect == "2"
                              ? getTransationType(
                                  App.localStorage
                                      .getString("userId")
                                      .toString(),
                          typeSelect)
                              : typeSelect == "3"
                                  ? getTransationCash(
                                      App.localStorage
                                          .getString("userId")
                                          .toString(),
                                    )
                                  : getTransation(
                                      App.localStorage
                                          .getString("userId")
                                          .toString(),
                                    ),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          TransactionModel? transationModel = snapshot.data;
                          double amount = 0.00;

                          return transationModel!.data!.length > 0
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      itemCount: transationModel.data!.length,
                                      itemBuilder: (context, index) {
                                        // if(transationModel.data![index].amount != null){
                                        //   amount =  double.parse(transationModel.data![index].amount.toString());
                                        // }
                                        if(transationModel.data![index].credit != null){
                                          transactionData =  transationModel.data![index].amount.toString();
                                          grams =  transationModel.data![index].credit == null || transationModel.data![index].credit == "" ? 0.0 :  double.parse(transationModel.data![index].credit.toString());
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Card(

                                            color: transationModel.data![index].purchaseType == "buy" ? Colors.green : Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                           child: Container(
                                             padding: EdgeInsets.all(15),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                          Image.asset(
                                          "assets/images/lockercupan.png",
                                          height: 50,
                                                width: 50,),
                                             Padding(
                                               padding: const EdgeInsets.only(left: 5.0, right: 5),
                                               child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    capitalize("${transationModel.data![index].purchaseType}"),
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    "${transationModel.data![index].ptype}",
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                          ),
                                             ),
                                              Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12),
                                              child: Container(
                                                width: 90,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: TextStyle(
                                                        color: colors.blackTemp,
                                                        fontSize: 17),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                          "${transationModel.data![index].createdAt}",
                                                          style: TextStyle(
                                                              color: colors.blackTemp)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ),
                                             Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Text(

                                                   "₹ ${transactionData.toString()}",
                                                  maxLines: 1,
                                                   //textScaleFactor: 6,
                                                   style: TextStyle(
                                                       color:
                                                       colors.blackTemp,
                                                       fontSize: 18),
                                                 ),
                                                 Text(
                                                   "${grams!.toStringAsFixed(6)}\ngms",
                                                   // "${transationModel.data![index].credit.toString()} gms",
                                                   maxLines: 2,
                                                   //textScaleFactor: 6,
                                                   style: TextStyle(
                                                       color:
                                                       colors.blackTemp,
                                                       fontSize: 18),
                                                 ),

                                               ],
                                             ),
                                              ]
                                        ),
                                           ),
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: double.infinity,
                                  child: Center(
                                      child: Text(
                                    "No History Yet",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )));
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                              ));
                        }
                      }),
              if(!isGold)
                loadingWish
                    ? orderList.length > 0
                    ? ListView.builder(
                        itemCount: orderList.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return OrderView(orderList[index],()async{
                            var result = await Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>OrderDetailsScreen(orderList[index])));
                          },);
                        })
                    : Center(
                      child: text("No Order Available"),
                    )
                    : Center(
                      child: CircularProgressIndicator(
                        color: MyColorName.primaryDark,
                      ),
                    ),
            ],
          )
         ,
        )
       );
  }

  var typeSelect = "0";
  bool isCash = false;

  void bottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: colors.secondary2,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Text(
                  "Select Type",
                  style: TextStyle(color: colors.blackTemp),
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      color: colors.blackTemp,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "1";
                    isCash = false;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "Only Gold-916 Transaction",
                    style: TextStyle(color: colors.blackTemp, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "2";
                    isCash = false;
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Only Gold-999 Transaction",
                    style: TextStyle(color: colors.blackTemp, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    typeSelect = "3";
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Only Cash Transaction",
                    style: TextStyle(color: colors.blackTemp, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
