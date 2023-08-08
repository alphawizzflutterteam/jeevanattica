
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Helper/myCart.dart';
import '../Helper/sellSilverModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Utils/Common.dart';



class SellDigitalSilverOnlye extends StatefulWidget {
  const SellDigitalSilverOnlye({Key? key}) : super(key: key);

  @override
  State<SellDigitalSilverOnlye> createState() => _SellDigitalSilverOnlyeState();
}

class _SellDigitalSilverOnlyeState extends State<SellDigitalSilverOnlye> {

  final choiceAmountController = TextEditingController();
  final choiceAmountControllerGram = TextEditingController();


  double resultGram = 0.0;
  var taotalPrice = 0.00;
  double silverRate = 60.00;
  TextStyle kTextStyle = TextStyle(
      fontSize: 14.0,
      color: Color(0xfffafcfb));
  double min = 0, max = 100;
  RangeValues rangeValues = RangeValues(0, 100);
  String? iserId;

  @override
  void initState() {
    super.initState();
     iserId = App.localStorage.getString("userId").toString();
    getWallet();
  }

  UserDetailsModel userDetailsModel = UserDetailsModel();
  double  silverWallet = 0.00;

  void getWallet() async {
    userDetailsModel =
    await userDetails(App.localStorage.getString("userId").toString());
    if (userDetailsModel != null &&
        userDetailsModel.data![0].goldWallet != null) {
      setState(() {
        double balanceSilver = double.parse(userDetailsModel.data![0].silverWallet.toString());
        silverWallet = balanceSilver / silverRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
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
          "Sell Digital Silver",
          style: TextStyle(color: Colors.white),
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
                image: DecorationImage(
                  image: AssetImage(
                    'assets/homepage/vertical.png',
                  ),
                  fit: BoxFit.cover,
                )),
            child: Column(
              children: [

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
                              'Start Buying \ndigital  Silver \nNow',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                color:colors.secondary2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Text(
                            '$silverWallet /gm',
                            style: TextStyle(
                              color:colors.secondary2,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Current buying price',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                              'Price Valid For',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              '02:44',
                              style: TextStyle(
                                color:colors.secondary2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 120.0, top: 12.0),
                  child: Text(
                    'How much you want to Pledge?',
                    style: TextStyle(
                      color: colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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

                            onChanged: (value) {
                              if(value.isNotEmpty){
                                resultGram = int.parse(value) / silverRate;
                                choiceAmountControllerGram.text = resultGram.toStringAsFixed(2).toString();
                              }else{
                                resultGram = 0.00;
                                choiceAmountControllerGram.clear();
                                choiceAmountController.clear();
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
                      child: Icon(Icons.compare_arrows, color: Colors.white, size: 35),
                      width: 35,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          controller: choiceAmountControllerGram,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),

                          onChanged:  (value) {

                            if(value.isNotEmpty){
                              double a = silverRate;
                              taotalPrice = int.parse(value) * a;
                              choiceAmountController.text = taotalPrice.toStringAsFixed(2).toString();
                            }else{
                              choiceAmountControllerGram.clear();
                              choiceAmountController.clear();
                              taotalPrice =0.00;
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
                    color: colors.primaryNew,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Total Available Gram :',
                          style: TextStyle(
                            color: Color(0xffE2E2E2),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(

                        '₹ ${silverWallet.toStringAsFixed(2).toString()}',
                        style: TextStyle(
                          color:colors.secondary2,
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
                    print("init %%");
                    SellSilverGoldModel a =  await sellGoldOrSilver(iserId, choiceAmountController.text,
                        resultGram, true, context);
                   // if(a != null && a.message != null ){
                    print("reach at dialog^^");
                      showDialog(
                        context: context,
                        builder: (ctxt) => new AlertDialog(
                          title: Text("${a.message}"),
                          actions: [
                            GestureDetector(
                              child: Center(child: Text("Okay")),
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    print("process finished**");
                  //  }
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
                    'SELL NOW  ₹${choiceAmountController.text.toString()}',
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