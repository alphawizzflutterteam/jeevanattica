import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Model/PrivacyPolicy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'Helper/Color.dart';
import 'Helper/myCart.dart';
import 'notifications.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Privacy Policy",
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
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage(
            //     'assets/homepage/vertical.png',
            //   ),
            //   fit: BoxFit.cover,
            // )
            ),
            child: Column(
              children: [
                FutureBuilder(
                    future: privacyPolicy(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      PrivacyPolicy model = snapshot.data;
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
              ],
            ),
          ),
        ));
  }
}
