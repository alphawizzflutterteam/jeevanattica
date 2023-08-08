import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/goldcoinbar.dart';
import 'package:flutter/material.dart';

import 'Helper/Color.dart';
import 'HomePage.dart';

class SilverCoinBar extends StatefulWidget {
  const SilverCoinBar({Key? key}) : super(key: key);

  @override
  State<SilverCoinBar> createState() => _SilverCoinBarState();
}

class _SilverCoinBarState extends State<SilverCoinBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        // Color(0xff15654F),
        leading: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  BottomBar()),
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.secondary2,
          ),

        ),
        title: Text(
          "Silver Coin/Bar",
          style: TextStyle(
            color: colors.black54,
            fontSize: 20,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.favorite_border, color:colors.secondary2),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.shopping_cart_rounded, color:colors.secondary2),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child:
                Icon(Icons.notifications_active, color:colors.secondary2),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height*1.1,
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
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  GoldCoinBar()),
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
                        SizedBox(width: 10,),
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
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  SilverCoinBar()),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) =>  SilverCoinBar()),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text('Available Item' ,style: TextStyle(
                              color: Colors.white,fontSize: 15,
                            ),),
                          ),
                          SizedBox(width: 15,),
                          Padding(
                            padding: const EdgeInsets.only(left: 132.0),
                            child: Image.asset('assets/buydigitalgold/filter.png',color: Colors.white,height: 15,),
                          ),
                          SizedBox(width: 10,),
                          Text('Filters',style: TextStyle(
                            color: Colors.white,fontSize: 15,
                          ),)  ,
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 4 / 4.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                          itemCount: 6,
                          itemBuilder: (context,index){
                            return Container(
                              height: 150,
                              width: 152,
                              decoration: BoxDecoration(
                                color: colors.white1,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),

                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.asset("assets/buydigitalgold/silvercoinbar.png",height: 80,),
                                  ),
                                  SizedBox(height: 20,),
                                  Card(
                                    color: Color(0xff15654F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 2,left: 5,right: 2),
                                          child: Text("0.5 Gram 24K  Gold Coin \n (99.99%) Pure",style: TextStyle(
                                            color: Color(0xffFFFFFF),
                                            fontSize: 12,
                                          ),),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child: Text("₹ 2700.50",style: TextStyle(
                                                color:colors.secondary2,
                                                fontSize: 18,
                                              ),),
                                            ),
                                            SizedBox(width: 10,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset("assets/buydigitalgold/fav.png",height: 20,),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          )));
  }
}
