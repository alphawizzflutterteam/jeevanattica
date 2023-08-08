import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:atticadesign/Helper/couponCode.dart';
import 'package:atticadesign/Provider/live_price_provider.dart';
import 'package:atticadesign/selldigitalgold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/Session.dart';
import 'Helper/myCart.dart';
import 'Model/banner_model.dart';
import 'Model/cart_model.dart';
import 'Utils/ApiBaseHelper.dart';
import 'Utils/Common.dart';
import 'Utils/constant.dart';
import 'buydigitalgold.dart';
import 'notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController buttonCarouselController = CarouselController();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  List<dynamic> cartList = [];
  int totalCount = 0;
  int currentindex = 0 ;


  getCart() async {
    try {
      setState(() {
        cartList.clear();
      });
      Map params = {
        "get_user_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);
      if (!response['error']) {
        cartList.clear();
        for (var v in response['cart_data']) {
        //  setState(() {
            cartList.add(CartData.fromJson(v));
        //  });
        }
        totalCount = cartList.length;
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {

      });
    }
  }

  get child => null;

  get imageSliders => null;

  ScrollController _scrollController = ScrollController();

  // _scrollToBottom() {
  //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: Duration(microseconds: 200), curve: Curves.easeOut);
  // }
  final colorizeColors = [
    Colors.yellow,
    Colors.white,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 14.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    var livePrice = Provider.of<LivePriceProvider>(context);
    getCart();
   // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return SafeArea(
      child: Scaffold(
       // backgroundColor: colors.white1,
          backgroundColor: colors.primary.withOpacity(0.5),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: colors.white1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                // image: DecorationImage(
                //   image: AssetImage('assets/homepage/Rectangledark.png'),
                //   fit: BoxFit.cover,
                // ),
              ),
              alignment: Alignment.centerRight,
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 90,
                        width: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/homepage/homelogo.png',
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 120,
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                          color: colors.primaryNew,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              //  height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      "Live",
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  pause: Duration(milliseconds: 100),
                                  isRepeatingAnimation: true,
                                  totalRepeatCount: 100,
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),

                              ),
                            ),
                            Text(
                              'Gold-916 Buy Price',
                              style: TextStyle(
                                color: colors.white1,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '₹ ${livePrice.gold1.toString()}/gm',
                              style: TextStyle(
                                color: colors.white1,
                                fontSize: 15,
                              ),
                            ),
                            Divider(
                              color: colors.secondary2
                              //Color(0xffF1D459),
                            ),
                            Text(
                              'Gold-999 Buy Price',
                              style: TextStyle(
                                color: colors.white1,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              '₹ ${livePrice.gold2.toString()}/gm',
                              style: TextStyle(
                                color: colors.white1,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async {
                        var result = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyCart()));
                        if(result == true){
                          setState((){

                            //count = 0 ;
                            totalCount = 0;
                          });
                        }
                        },
                        child: Image.asset(
                          "assets/images/shop.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom:16),
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color:colors.secondary2,
                            shape: BoxShape.circle
                          ),
                          child: Center(
                            child: Text("${totalCount.toString()}", style: TextStyle(
                                color: Colors.black,  fontSize: 12, fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotiPage()),
                          );
                        },
                        child: Image.asset(
                          'assets/homepage/ring_home.png',
                          height: 24,
                          width: 24,
                          color:colors.secondary2 ,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 15),
              height: 190,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.white1,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 20.0, left: 20),
                      //       child: Image.asset(
                      //         'assets/homepage/goldbrick.png',
                      //         height: 70,
                      //         width: 100,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //  /*   Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(right: 20.0, top: 30),
                      //           child: Text(
                      //             '0.0000gm',
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: 30,
                      //             ),
                      //           ),
                      //         ),
                      //
                      //       ],
                      //     ),*/
                      //
                      //   ],
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10),
                              child: Image.asset(
                                'assets/homepage/goldbrick.png',
                                height: 70,
                                width: 100,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Buy/Sell your own \ndigital gold',
                              style: TextStyle(
                                color: colors.blackTemp,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              '99.99K Pure Gold',
                              style: TextStyle(
                                color:colors.secondary2,
                                fontSize: 15,
                              ),
                            ),


                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BuyDigitalGold(
                                  goldRate: livePrice.gold1.toString(),
                                  gold1Rate : livePrice.gold2.toString()

                              )),
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
                            height: 35,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Buy",
                                style: TextStyle(color: colors.white1, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SellDigitalGold(
                                  goldRate: livePrice.gold1.toString(),
                                  gold1Rate : livePrice.gold2.toString()

                              )),
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
                            height: 35,
                            width: 100,
                            child: Center(
                              child: Text(
                                "Sell",
                                style: TextStyle(color: colors.white1, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Offer For You',
                style: TextStyle(
                  color: colors.blackTemp,
                  fontSize: 18,
                ),
              ),
            ),

            Container(
              height: 200,
              child: FutureBuilder(
                  future: getBaneerHomeScreen(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    BannerModel model = snapshot.data;
                    if (snapshot.hasData) {
                      return model.error == false
                          ?  Container(
                        height: 180,
                        width: double.infinity,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 2),
                            autoPlayAnimationDuration:
                            Duration(milliseconds: 1200),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            height: 180,
                            onPageChanged: (position, reason) {
                              setState(() {
                                currentindex = position;
                              });
                              print(reason);
                              print(CarouselPageChangedReason.controller);
                            },
                          ),
                          items: model.data!.map((val) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${val.toString()}",
                                    fit: BoxFit.fill,
                                  )),
                            );
                          }).toList(),
                        ),
                        // margin: EdgeInsetsDirectional.only(top: 10),
                        // child: PageView.builder(
                        //   itemCount: homeSliderList.length,
                        //   scrollDirection: Axis.horizontal,
                        //   controller: _controller,
                        //   pageSnapping: true,
                        //   physics: AlwaysScrollableScrollPhysics(),
                        //   onPageChanged: (index) {
                        //     context.read<HomeProvider>().setCurSlider(index);
                        //   },
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return pages[index];
                        //   },
                        // ),
                      )
                      // Container(
                      //         margin: EdgeInsets.symmetric(horizontal: 16),
                      //         child: ListView.builder(
                      //             controller: _scrollController,
                      //             shrinkWrap: true,
                      //             itemCount: model.data!.length,
                      //             scrollDirection: Axis.horizontal,
                      //             itemBuilder: (BuildContext context, index) {
                      //               return Container(
                      //                 width: MediaQuery.of(context).size.width ,
                      //                 margin: EdgeInsets.all(16),
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(16),
                      //                   child: Image.network(
                      //                     model.data![index].toString(),
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               );
                      //             }),
                      //       )
                          : Container(
                              child: Text("No Data"),
                            );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Container(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        ),
                      );
                    }
                  }),
            ),

            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/homepage/offer.png',
                    ),
                    fit: BoxFit.contain,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20.0, top: 45, left: 2),
                        child: Text(
                          'Have Coupon Code',
                          style:
                              TextStyle(color: colors.blackTemp, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 15),
                        child: Text(
                          'Redeem to get Free gold',
                          style:
                              TextStyle(color: colors.blackTemp, fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CouponCode()),
                            );
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
                              "Get Now",
                              style: TextStyle(color: colors.secondary2),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ],
              ),
            ),
           /* Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/homepage/scooter.png',
                    ),
                    fit: BoxFit.fill,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 30.0, top: 20, left: 15),
                        child: Text(
                          'Gold Delivery',
                          style:
                              TextStyle(color:colors.secondary2, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 30.0),
                        child: Text(
                          'Get 24k 99.99% pure Gold Items \n delivered at your home',
                          style:
                              TextStyle(color: colors.black54, fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              colors: [
                               colors.secondary2,
                                Color(0xffB27E29),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: Center(
                            child: Text(
                          "Get Now",
                          style: TextStyle(color: Color(0xff0C3B2E)),
                        )),


                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),*/
          ],
        )),
        /*floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                 S
                },
                child: Center(
                  child: Image.asset(
                    'assets/homepage/buy.png',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SellDigitalGold()),
                  );
                },
                child: Image.asset('assets/homepage/sell.png'),
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}
