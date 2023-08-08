import 'dart:async';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/order_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';
import '../Utils/Common.dart';


class AddOrderReview extends StatefulWidget {
  OrderModel model;


  AddOrderReview(this.model);

  @override
  State<AddOrderReview> createState() => _AddOrderReviewState();
}

class _AddOrderReviewState extends State<AddOrderReview> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  double value = 4.5;
  TextEditingController controller =new TextEditingController();
  List<String> productId = [];
  
  
  giveFeedbackApi() async {
    try {
      setState(() {
        loading = false;
      });
      for(int i = 0;i<widget.model.orderItems!.length;i++){
        productId.add(widget.model.orderItems![i].id.toString());
      }
      Map params = {
        "user_id":App.localStorage.getString("userId").toString(),
        "product_id": widget.model.orderItems!.first.productId,
        "comment": controller.text.toString(),
        "rating": value.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "set_product_rating"), params);
      setState(() {
        loading = true;
      });
      setSnackbar(response['message'].toString(), context);
      if (!response['error']) {
        Navigator.pop(context,"yes");
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: getWidth(10),vertical: getHeight(20)),
          decoration: boxDecoration(radius: 20,bgColor: colors.secondary2.withOpacity(0.4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.clear,
                    color: MyColorName.colorBg1,
                  ),
                ),
              ),
              Image.asset(
                'assets/order_feedback.png',
                height: getHeight(208),
              ),
              boxHeight(25),
              text(
                'Customer Feedback is really important to us Please Tell us how Was your experience',
                fontFamily: fontRegular,
                textColor: MyColorName.colorEdit,
                isCentered: true,
              ),
              boxHeight(20),
              RatingBar.builder(
                initialRating: value,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 5.w,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    value = rating;
                  });
                  print(rating);
                },
              ),
              boxHeight(10),
              Container(
                  alignment: Alignment.center,
                  child: text('Great !', textColor: Colors.green)),
              boxHeight(20),
              Container(
                alignment: Alignment.centerLeft,
                child: text('Write Comment', fontFamily: fontRegular,
                  textColor: MyColorName.colorEdit,
                  isCentered: false,),
              ),
              boxHeight(10),
              Container(
                color: colors.secondary2.withOpacity(0.8),
                child: TextFormField(

                  minLines: 5,
                  maxLines: 15,
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10)
                  ),
                ),
              ),
              boxHeight(41),
              InkWell(
                onTap: (){
                  if(controller.text==""){
                    setSnackbar("Enter Comment", context);
                    return;
                  }
                  giveFeedbackApi();
                },
                child: Container(
                  width: getWidth1(522),
                  height: getHeight1(68),
                  decoration: boxDecoration(
                      radius: 48, bgColor: colors.secondary2,),
                  child: Center(
                    child: loading?text(
                      "Submit",
                      fontFamily: fontMedium,
                      textColor: colors.blackTemp,
                      fontSize: 10.sp,
                    ):CircularProgressIndicator(color: MyColorName.appbarBg,),
                  ),
                ),
              ),
              boxHeight(41),
            ],
          ),
        ),
      ),
    );
  }
}
