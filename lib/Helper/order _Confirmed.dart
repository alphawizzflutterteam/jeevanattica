
import 'package:atticadesign/HomePage.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Color.dart';
class OrderConfirmed extends StatefulWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  State<OrderConfirmed> createState() => _OrderConfirmedState();
}

class _OrderConfirmedState extends State<OrderConfirmed> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomBar()), (route) => false);
        return Future.value();
      },
      child: Scaffold(
        //backgroundColor: Color(0xFF15654F),

        body: SafeArea(
          child: Container(
            width: 100.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 350,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/succes.png'),
                      fit: BoxFit.contain
                    )
                  ),

                ),
                Text("Order Confirmed",style: TextStyle(color: colors.blackTemp,fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Thank You For Your Order,\nYou Will Receive Email Confirmation Shortly",
                  style: TextStyle(color: colors.blackTemp,fontSize: 15),),
                SizedBox(height: 50,),
                Container(
                  height: 50.0,
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      padding: EdgeInsets.all(0.0),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomBar()), (route) => false);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xffF1D459), Color(0xffB27E29)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          "CONTINUE SHOPPING",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colors.blackTemp,fontSize: 17
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),

        )

      ),
    );
  }
}
