import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Model/GetNotificationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Helper/Color.dart';
import 'Helper/myCart.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({Key? key}) : super(key: key);

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Color(0xff15654F),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primaryNew,
          //Color(0xff15654F),
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
            "Notification",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyCart()),
                        );
                      },
                      child: Icon(Icons.shopping_cart_rounded,
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
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Container(
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //   image: AssetImage(
                  //     'assets/homepage/vertical.png',
                  //   ),
                  //   fit: BoxFit.cover,
                  // )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: FutureBuilder(
                        future: getNotification(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          GetNotificationModel notifyModel = snapshot.data;
                          if (snapshot.hasData) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 1,
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: notifyModel.data!.length,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) => Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12.0, left: 12.0),
                                            child: Image.asset(
                                              'assets/buydigitalgold/notification.png',
                                              height: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${notifyModel.data![index].title}',
                                                style: TextStyle(color: colors.blackTemp),
                                              ),
                                              Text(
                                                '${notifyModel.data![index].message}',
                                                style: TextStyle(color: colors.blackTemp),
                                              )
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => Divider(
                                    indent: 20,
                                    endIndent: 20,
                                    color: colors.blackTemp,
                                  ),

                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  )),
            )));
  }
}
