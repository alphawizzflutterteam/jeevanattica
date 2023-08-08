import 'package:atticadesign/Helper/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'Color.dart';
class ProductDetailsDialog extends StatefulWidget {
  const ProductDetailsDialog({Key? key}) : super(key: key);

  @override
  State<ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<ProductDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      insetPadding: EdgeInsets.all(10),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: 400,
            height: 550,

            padding: EdgeInsets.only(left: Constants.padding,top: 10,
                right: Constants.padding,bottom: Constants.padding
            ),
            margin: EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xff0C3B2E),
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                      blurRadius: 20
                  ),
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title:  InkWell(
                      onTap: (){
                      Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/feedback.png",height: 150,)),
                  trailing: Icon(Icons.clear_rounded,color: Colors.white,),
                ),

                SizedBox(height: 15,),
                Text("Customer Feedback is really important to us "
                    ,style: TextStyle(fontSize: 14,color: Colors.white),textAlign: TextAlign.center),
                SizedBox(height: 10,),
                Text(" Please Tell us how Was your experience "
                    ,style: TextStyle(fontSize: 12  ,color:colors.secondary2),textAlign: TextAlign.center),
                SizedBox(height: 10,),
                RatingBar.builder(
                  initialRating:4,
                  itemSize: 25.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding:
                  EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 22,),
                Text(" Great ! "
                    ,style: TextStyle(fontSize: 14  ,color: Color(0xff0BA84A)),textAlign: TextAlign.center),
               ListTile(
                 leading: Text(" Write Comment "
                     ,style: TextStyle(fontSize: 14  ,color: Color(0xffffffff)),textAlign: TextAlign.center),
                 trailing: Text(" 35/450 "
                     ,style: TextStyle(fontSize: 14  ,color: Color(0xffffffff)),textAlign: TextAlign.center),
               ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff376356)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      maxLines: 1,
                      style: TextStyle(fontSize: 17),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                       // hintStyle: TextStyle(color: Color(0xff376356)),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: 50.0,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                      padding: EdgeInsets.all(0.0),
                    ),
                    onPressed: () {

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
                          "SUBMIT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colors.white1,fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
          // Positioned(
          //   left: Constants.padding,
          //   right: Constants.padding,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.transparent,
          //     radius: Constants.avatarRadius,
          //     child: ClipRRect(
          //         borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
          //         child: Image.asset("assets/model.jpeg")
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}
