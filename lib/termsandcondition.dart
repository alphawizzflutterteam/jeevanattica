import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'Api/api.dart';
import 'Helper/Color.dart';
import 'Helper/myCart.dart';
import 'Model/termsandConditions_model.dart';
import 'notifications.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colors.primaryNew,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
          ),
          title: Text(
            "Terms And Condition",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyCart()),
                    );
                  },
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotiPage()),
                        );
                      },
                        child: Icon(Icons.shopping_cart_rounded, color:colors.secondary2))),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child:
                  InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NotiPage()),
                        );
                      },
                      child: Icon(Icons.notifications_active, color:colors.secondary2)),
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height * 1.5,
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(
                //     'assets/homepage/vertical.png',
                //   ),
                //   fit: BoxFit.cover,
                // )
            ),
            child: Column(
              children: [
                FutureBuilder(
                    future: termsandConditions(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      TermsandConditionsModel model = snapshot.data;
                      if (snapshot.hasData) {
                        var htmlData = "${model.data![0].value}";
                        return model.error == false
                            ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Html(
                            data: htmlData,
                          ),
                        )
                            : Container(
                          child: Text("No Data"),
                        );
                      } else if (snapshot.hasError) {
                        return Icon(Icons.error_outline);
                      } else {
                        return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    }),
                // FutureBuilder(
                //     future: termsandConditions(),
                //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                //       TermsandConditionsModel model = snapshot.data;
                //       if (snapshot.hasData) {
                //         return model.error == false ? Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Text('${model.data![0].value}',
                //             textAlign: TextAlign.justify,style: TextStyle(
                //               color: Colors.white.withOpacity(1),
                //             ),),
                //         ) : Container(child: Text("No Data"),);
                //       } else if (snapshot.hasError) {
                //         return Icon(Icons.error_outline);
                //       } else {
                //         return CircularProgressIndicator();
                //       }
                //     }),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Text('''Lorem ipsum dolor sit amet,  et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et   ''',textAlign: TextAlign.justify,style: TextStyle(
                //     color: Colors.white.withOpacity(1),
                //
                //   ),),
                // ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
    );
  }
}
