/*
import 'package:atticadesign/Helper/myAccount.dart';
import 'package:atticadesign/orderdetails.dart';
import 'package:flutter/material.dart';


class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0F261E),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff15654F),
          leading: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MyAccount()),
                );
              },
              child: Image.asset("assets/images/newbackss.png",height: 80,)),
          title: Text(
            "Order History",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.shopping_cart_rounded, color:colors.secondary2),
                SizedBox(

                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child:
                  InkWell(
                      onTap: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => NotiPage()),
                        // );
                      },
                      child: Icon(Icons.notifications_active, color:colors.secondary2)),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: AssetImage(
                //         'assets/homepage/vertical.png',
                //       ),
                //       fit: BoxFit.cover,
                //     )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff376356),
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              height: 50,
                              width: 220,
                              child: TextField(
                                maxLines: 1,
                                style: TextStyle(fontSize: 17),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  hintStyle: TextStyle(color:colors.secondary2),
                                  prefixIcon: Icon(Icons.search,color: Colors.yellow,size: 30,)
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15  ,),
                          Image.asset('assets/images/filter.png',height: 20,),SizedBox(width: 10,),
                          SizedBox(width: 10,),
                          Text('Filters',style: TextStyle(
                            color: Colors.white,fontSize: 15,
                          ),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OrderDetailsPage()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: colors.primaryNew,
                          ),


                          height: 150,
                          width: 380,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Color(0xff15654F),
                                  ),
                                  height: 120,
                                  width: 120,
                                  child: Image.asset("assets/images/gold.png",height: 20,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 10),
                                  child: Column(
                                    children: [
                                      Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                      SizedBox(height: 10,),
                                      Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                      SizedBox(height: 20,),
                                      Text("Wt: 0.5 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 10),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/delivered.png",height: 30,),
                                      SizedBox(height: 10,),
                                      Text("Delivered",style: TextStyle(color: Color(0xff98C924),fontSize: 15 ),),
                                      SizedBox(height: 30,),
                                      Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: colors.primaryNew,
                        ),
                        height: 150,
                        width: 380,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Color(0xff15654F),
                                ),
                                height: 120,
                                width: 120,
                                child: Image.asset("assets/images/goldsbisket.png",height: 20,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                    SizedBox(height: 10,),
                                    Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    SizedBox(height: 20,),
                                    Text("Wt: 10 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 30,),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/pendingDelivered.png",height: 30,),
                                    SizedBox(height: 10,),
                                    Text("Pending",style: TextStyle(color: Color(0xffFF0000),fontSize: 15 ),),
                                    SizedBox(height: 30,),
                                    Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: colors.primaryNew,
                        ),


                        height: 150,
                        width: 380,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Color(0xff15654F),
                                ),
                                height: 120,
                                width: 120,
                                child: Image.asset("assets/images/goldbiskit.png",height: 20,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                    SizedBox(height: 10,),
                                    Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    SizedBox(height: 20,),
                                    Text("Wt: 10 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 30,),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/delivered.png",height: 30,),
                                    SizedBox(height: 10,),
                                    Text("Delivered",style: TextStyle(color: Color(0xff98C924),fontSize: 15 ),),
                                    SizedBox(height: 30,),
                                    Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: colors.primaryNew,
                        ),


                        height: 150,
                        width: 380,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Color(0xff15654F),
                                ),
                                height: 120,
                                width: 120,
                                child: Image.asset("assets/images/gold.png",height: 20,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                    SizedBox(height: 10,),
                                    Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    SizedBox(height: 20,),
                                    Text("Wt: 0.5 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 30,),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/delivered.png",height: 30,),
                                    SizedBox(height: 10,),
                                    Text("Delivered",style: TextStyle(color: Color(0xff98C924),fontSize: 15 ),),
                                    SizedBox(height: 30,),
                                    Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: colors.primaryNew,
                        ),
                        height: 150,
                        width: 380,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Color(0xff15654F),
                                ),
                                height: 120,
                                width: 120,
                                child: Image.asset("assets/images/goldsbisket.png",height: 20,),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                    SizedBox(height: 10,),
                                    Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    SizedBox(height: 20,),
                                    Text("Wt: 10 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 30,),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 10),
                                child: Column(
                                  children: [
                                    Image.asset("assets/images/pendingDelivered.png",height: 30,),
                                    SizedBox(height: 10,),
                                    Text("Pending",style: TextStyle(color: Color(0xffFF0000),fontSize: 15 ),),
                                    SizedBox(height: 30,),
                                    Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 120),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: colors.primaryNew,
                          ),


                          height: 150,
                          width: 380,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Color(0xff15654F),
                                  ),
                                  height: 120,
                                  width: 120,
                                  child: Image.asset("assets/images/goldbiskit.png",height: 20,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 10),
                                  child: Column(
                                    children: [
                                      Text("24K Gold Coin \n(99.99%) Pure",style: TextStyle(color: Colors.yellow),),
                                      SizedBox(height: 10,),
                                      Text("₹2700.50",style: TextStyle(color: Colors.white,fontSize: 20),),
                                      SizedBox(height: 20,),
                                      Text("Wt: 10 gm",style: TextStyle(color: Colors.white,fontSize: 15),)
                                    ],
                                  ),
                                ),
                                SizedBox(width: 30,),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20,left: 10),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/delivered.png",height: 30,),
                                      SizedBox(height: 10,),
                                      Text("Delivered",style: TextStyle(color: Color(0xff98C924),fontSize: 15 ),),
                                      SizedBox(height: 30,),
                                      Text("26/02/2022",style: TextStyle(color: Colors.white,fontSize: 14),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
        )
    );

  }
}
*/
