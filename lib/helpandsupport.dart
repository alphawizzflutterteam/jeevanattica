import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Helper/Color.dart';
import 'Helper/myCart.dart';
import 'bottom_navigation.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  bool _showContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Help and Support",
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
      //backgroundColor: colors.primary2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Business Support"),
                              Text("General Support")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Business@Attica.com"),
                              Text("Support@Attica.com")
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Image.asset("assets/whatsapp.png"
            ,width: 315),
            SizedBox(height: 20.0,),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 4.33.w,right: 4.33.w,bottom:1.87.h
                        ),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: colors.primary),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                  "How can I update my profile",
                                  style: TextStyle(color: colors.blackTemp, fontSize: 14.0),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    _showContent = !_showContent;
                                  });
                                },
                                child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colors.grad1Color,
                                    ),
                                    child: _showContent
                                        ? Icon(
                                      Icons.remove,
                                      color: colors.primary,
                                      size: 20.0,
                                    )
                                        : Icon(
                                      Icons.add,
                                      color: colors.primary,
                                      size: 20.0,
                                    ))),
                          ],
                        ),
                      ),
                      _showContent
                          ? Container(
                        transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                        width: MediaQuery.of(context).size.width,
                        //margin: EdgeInsets.only(top: 0.0),
                        margin: EdgeInsets.only(
                            left: 4.33.w,right: 4.33.w,bottom:1.87.h
                        ),
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 15.0, bottom: 20.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                            color: colors.primary),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit",
                            style: TextStyle(
                              color: colors.blackTemp,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                          : Container()
                    ],
                  );
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("If you Can't find a solution You can Write About Your Problem and Send to us",style: TextStyle(color: colors.grad1Color),),
            ),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
                    hintText: 'Describe Your Problem here',
                    hintStyle:
                        TextStyle(color: colors.blackTemp),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomBar()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                    color: colors.grad1Color,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text(
                    "Send",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: colors.whiteTemp),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Color(0xff15654F),
    //     leading: InkWell(
    //         onTap: () {
    //           Navigator.pop(context);
    //         },
    //         child: Image.asset(
    //           'assets/images/newbackss.png',
    //         )),
    //     title: Text(
    //       "Help and Support",
    //       style: TextStyle(
    //         color: colors.black54,
    //         fontSize: 20,
    //       ),
    //     ),
    //     actions: [
    //       Row(
    //         children: [
    //           InkWell(
    //               onTap: () {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(builder: (context) => MyCart()),
    //                 );
    //               },
    //               child: Icon(Icons.shopping_cart_rounded,
    //                   color:colors.secondary2)),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(right: 15.0),
    //             child: InkWell(
    //                 onTap: () {
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(builder: (context) => NotiPage()),
    //                   );
    //                 },
    //                 child: Icon(Icons.notifications_active,
    //                     color:colors.secondary2)),
    //           ),
    //         ],
    //       )
    //     ],
    //   ),
    //   body: SingleChildScrollView(
    //       scrollDirection: Axis.vertical,
    //       child: ConstrainedBox(
    //           constraints: BoxConstraints(
    //             maxHeight: MediaQuery.of(context).size.height * 1.7,
    //           ),
    //           child: Container(
    //               // height: MediaQuery.of(context).size.height,
    //               width: MediaQuery.of(context).size.width,
    //               decoration: BoxDecoration(
    //                   image: DecorationImage(
    //                 image: AssetImage(
    //                   'assets/homepage/vertical.png',
    //                 ),
    //                 fit: BoxFit.cover,
    //               )),
    //               child: Column(children: [
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 100,
    //                   width: 350,
    //                   child: Card(
    //                       color: Color(0xff15654F),
    //                       child: Column(
    //                         children: [
    //                           Row(
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 10.0, top: 15),
    //                                 child: Text(
    //                                   'Business Support',
    //                                   style: TextStyle(
    //                                     fontSize: 15,
    //                                     color: Color(0xffFFFFFF),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 width: 30,
    //                               ),
    //                               Padding(
    //                                 padding: const EdgeInsets.only(
    //                                     left: 25.0, top: 15),
    //                                 child: Text(
    //                                   'General Support',
    //                                   style: TextStyle(
    //                                     fontSize: 15,
    //                                     color: Color(0xffFFFFFF),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(
    //                             height: 20,
    //                           ),
    //                           Row(
    //                             children: [
    //                               Padding(
    //                                 padding: const EdgeInsets.only(left: 10.0),
    //                                 child: Text(
    //                                   'Business@Attica.com',
    //                                   style: TextStyle(
    //                                     fontSize: 15,
    //                                     color: Color(0xffFFFFFF),
    //                                   ),
    //                                 ),
    //                               ),
    //                               SizedBox(
    //                                 width: 30,
    //                               ),
    //                               Text(
    //                                 'Support@Attica.com',
    //                                 style: TextStyle(
    //                                   fontSize: 15,
    //                                   color: Color(0xffFFFFFF),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       )),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 100,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.all(Radius.circular(10)),
    //                       image: DecorationImage(
    //                           image: AssetImage('assets/images/backcover.png'),
    //                           fit: BoxFit.cover)),
    //                   child: Row(
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.only(left: 8.0),
    //                         child: Text(
    //                           "You Can have Live Whats app \n Chat With Our Support Team",
    //                           style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: 18,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/plusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/minusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 150,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(
    //                               left: 10.0, right: 10.0, top: 5, bottom: 5.0),
    //                           child: Text(
    //                             '''Lorem ipsum dolor sit amet, consetetur sadipscing elitr,\n  sed diam nonumy eirmod tempor invidunt ut labore \n  et dolore magna aliquyam erat, sed diam voluptua.\n At vero eos et accusam et justo duo \n dolores et ea  rebum. Stet clita kasd gubergren, \n no sea takimata sanctus est Lorem  ipsum dolor \n sit amet. Lorem ipsum dolor sit''',
    //                             textAlign: TextAlign.justify,
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 13,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/plusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/minusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/plusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 70,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 12.0),
    //                           child: Text(
    //                             "How can I update my profile",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           width: 60,
    //                         ),
    //                         Image.asset(
    //                           'assets/plusbutton.png',
    //                           height: 40,
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Text(
    //                   '''If you Can't find a solution You can Write About Your Problem and Send to us''',
    //                   textAlign: TextAlign.justify,
    //                   style: TextStyle(
    //                     fontSize: 10,
    //                     color:colors.secondary2,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   height: 120,
    //                   width: 350,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   ),
    //                   child: Card(
    //                     color: Color(0xff15654F),
    //                     child: Row(
    //                       children: [
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.only(bottom: 70.0, left: 10),
    //                           child: Text(
    //                             "Describe Your Problem here",
    //                             style: TextStyle(
    //                               color: Colors.white,
    //                               fontSize: 15,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => OrderConfirmPage()),
    //                     );
    //                   },
    //                   child: Container(
    //                     height: 50,
    //                     width: 250,
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.all(Radius.circular(30)),
    //                         gradient: LinearGradient(colors: [
    //                          colors.secondary2,
    //                           Color(0xffB27E29),
    //                         ])),
    //                     child: Center(
    //                       child: Text(
    //                         "SEND",
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 20,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //               ])))),
    // );
  }
}