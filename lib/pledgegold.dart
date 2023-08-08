import 'package:atticadesign/pledgesilver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:hakka/values/AppColor.dart';

import 'Helper/Color.dart';
import 'Helper/myCart.dart';
import 'notifications.dart';

class PledgeGold extends StatefulWidget {
  const PledgeGold({Key? key}) : super(key: key);

  @override
  State<PledgeGold> createState() => _PledgeGoldState();
}

class _PledgeGoldState extends State<PledgeGold> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('1', "100");
  double _currentSliderValue = 20;
  double priceRange  = 10;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff15654F),
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
          "Pledge Gold",
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) =>  PledgeGold()),
                              // );
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
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PledgeSilver()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>  PledgeSilver()),
                                      // );
                                    },
                                    child: Image.asset(
                                      'assets/homepage/silverbrick.png',
                                      height: 30,
                                    ),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 50,
                    width: 335,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: colors.primaryNew,
                    ),
                    child: ListTile(
                      leading: Text(
                        'Pledge Gold jewllery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 12.0),
                      //       child: Text(
                      //         'Pledge Gold jewllery',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 20,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 40,
                      //     ),
                      //     Image.asset(
                      //       'assets/buydigitalgold/arrowback.png',
                      //       height: 20,
                      //       width: 20,
                      //     )
                      //   ],
                      // ),
                      trailing: Image.asset(
                        'assets/buydigitalgold/arrowback.png',
                        height: 20,
                        width: 20,
                      ),
                    )),
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
                        image: AssetImage("assets/homepage/coinback.png"),
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
                              'Start Buying \ndigital  gold \nNow',
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
                            '5362.39/gm',
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
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       height: 80,
                //       width: 50,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(10.0),
                //             bottomLeft: Radius.circular(10.0)),
                //         color: colors.primaryNew,
                //       ),
                //       child: Center(
                //           child: Column(
                //             children: [
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Icon(Icons.propane_tank_outlined,color: Colors.orange.withOpacity(0.6),),
                //               SizedBox(height: 5,),
                //               Text(
                //                 " Grams",
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                 ),
                //               )
                //             ],
                //           )
                //
                //          ),
                //     ),
                //     Container(
                //       height: 80,
                //       width: 270
                //       ,
                //       padding: EdgeInsets.only(left: 20.0),
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //             bottomRight: Radius.circular(10.0),
                //             topRight: Radius.circular(10.0)),
                //         color: colors.primaryNew,
                //       ),
                //       child: Container(
                //         child: Center(
                //           child: TextFormField(
                //             maxLength: 20,
                //             // controller: mobileC,
                //             keyboardType: TextInputType.number,
                //             decoration: InputDecoration(
                //               counterText: "",
                //               border: InputBorder.none,
                //               hintText: " 10 ",
                //               hintStyle: TextStyle(
                //                   color: Colors.amber.withOpacity(0.3)
                //               ),
                //
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 5,
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(priceRange.toString()),
                    new Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: colors.primaryNew
                        ),

                        padding: EdgeInsets.only(left: ((MediaQuery.of(context).size.width-10)/10)/2,right: ((MediaQuery.of(context).size.width-10)/10)/2),
                        width: MediaQuery.of(context).size.width,
                        child: new CupertinoSlider(
                          thumbColor: Colors.orange,
                          activeColor: colors.primaryNew,
                          value: priceRange,
                          onChanged: (value) {
                            setState(() {
                              priceRange = value;
                            });
                          },
                          max: 100,
                          min: 0,
                          divisions: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Image.asset(
                //       'assets/buydigitalgold/meter.png',
                //       height: 50,
                //       width: 340,
                //     ),
                //   ],
                // ),
                // ListTile(
                //   leading:   Text(
                //     'Min',
                //     style: TextStyle(
                //       color: Color(0xffffffff),
                //
                //       fontSize: 20,
                //     ),
                //   ),
                //   trailing:  Text(
                //     'Max',
                //     style: TextStyle(
                //       color: Color(0xffffffff),
                //
                //       fontSize: 20,
                //     ),
                //   ),
                // ),

                // SliderTheme(
                //   data: SliderThemeData(
                //     trackHeight: 15,
                //   ),
                //   child: RangeSlider(
                //       divisions: 10,
                //       // 0xff24745E
                //       activeColor: colors.primaryNew,
                //       inactiveColor: colors.primaryNew,
                //       min: 1,
                //       max: 100,
                //       values: values,
                //       labels: labels,
                //       onChanged: (value) {
                //         print("START: ${value.start}, End: ${value.end}");
                //
                //         setState(() {
                //           values = value;
                //           labels = RangeLabels(
                //               "${value.start.toInt().toString()}\$",
                //               "${value.start.toInt().toString()}\$");
                //         });
                //       }),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("min",style: TextStyle(color: Colors.white),),
                      SizedBox(
                        width: 270,
                      ),
                    Text("max",style: TextStyle(color: Colors.white)),
                  ],
                ),

                // ListTile(
                //   leading: Text(
                //     'Min',
                //     style: TextStyle(
                //       color: Color(0xffffffff),
                //       fontSize: 12,
                //     ),
                //   ),
                //   trailing: Text(
                //     'Max',
                //     style: TextStyle(
                //       color: Color(0xffffffff),
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Row(
                    children: [
                      Text(
                        'Available Gold Balance :  ',
                        style: TextStyle(
                          color: Color(0xffE2E2E2),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '65.00gm',
                        style: TextStyle(
                          color:colors.secondary2,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                          'Total Available Amount:   ',
                          style: TextStyle(
                            color: Color(0xffE2E2E2),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        ' 65.00gm',
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
                  height: 40,
                ),
                Container(
                  height: 50,
                  width: 340,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      gradient: LinearGradient(colors: [
                       colors.secondary2,
                        Color(0xffB27E29),
                      ])),
                  child: Center(
                    child: Text(
                      'PLEDGE NOW',
                      style: TextStyle(
                        color: Color(0xff0F261E),
                        fontSize: 18,
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
