import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';

class VoucherListView extends StatefulWidget {
  const VoucherListView({Key? key}) : super(key: key);

  @override
  State<VoucherListView> createState() => _VoucherListViewState();
}

class _VoucherListViewState extends State<VoucherListView> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  bool loadingCart = false;
  int? currentIndex;
  List<VoucherModel> voucherList = [];
  int totalCount = 0, currentCount = 0;
  String productImage = "", productName = "";

  getPromo() async {
    try {
      setState(() {
        loadingCart = false;
        totalCount = 0;
        voucherList.clear();
      });
      Map params = {
        // "get_promo_codes": "1",
        // "user_id": curUserId.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_promo_codes"), params);
      setState(() {
        loadingCart = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            voucherList.add(new VoucherModel(
                v['id'],
                v['promo_code'],
                v['message'],
                v['start_date'],
                v['end_date'],
                v['no_of_users'],
                v['minimum_order_amount'],
                v['discount'],
                v['discount_type'],
                v['max_discount_amount'],
                v['repeat_usage'],
                v['no_of_repeat_usage'],
                v['status'],
                v['date_created'],
                v['image']));
          });
        }
      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
    if (currentCount == 0) {
      setState(() {
        currentCount = totalCount;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPromo();
    // getCouponcode();
  }

  TextEditingController couponCon = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xFF15654F),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xFF15654F),
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
          "Coupon code",
          style: TextStyle(color: colors.white1),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: getHeight1(1280),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              // boxHeight(25),
              // Container(
              //     height: 60,
              //     width: getWidth1(630),
              //
              //     decoration: boxDecoration(
              //         radius: 12,
              //         color: Colors.white.withOpacity(0.3),
              //         bgColor: Colors.transparent),
              //     child: TextFormField(
              //         controller: couponCon,
              //         decoration: InputDecoration(
              //             border: InputBorder.none,
              //             labelText: "Enter Coupon",
              //             labelStyle: TextStyle(
              //               color: Colors.white,
              //             ),
              //             suffix: InkWell(
              //                 onTap: (){
              //                   if(couponCon.text!=""){
              //                     Navigator.pop(context,VoucherModel(
              //                         "v['id']",
              //                         couponCon.text.toString(),
              //                         "Offers",
              //                         " v['start_date']",
              //                         "v['end_date']",
              //                         "v['no_of_users']",
              //                         "v['minimum_order_amount']",
              //                         "v['discount']",
              //                         "v['discount_type']",
              //                         "v['max_discount_amount']",
              //                         "v['repeat_usage']",
              //                         "v['no_of_repeat_usage']",
              //                         "v['status']",
              //                         " v['date_created']","v['image']"));
              //                   }
              //                 },
              //                 child: Container(
              //                     padding: EdgeInsets.symmetric(horizontal: getWidth1(20)),
              //                     child: text("Apply",textColor: MyColorName.primaryDark))),
              //             prefixIcon: Icon(
              //               Icons.local_offer,
              //               color: Colors.white,
              //             )))),
              boxHeight(12),
              // Container(
              //     width: getWidth1(622),
              //     child: text("Voucher",
              //         fontSize: 14.sp, fontFamily: fontBold,isCentered: true)),
              // boxHeight(25),
              loadingCart
                  ? voucherList.length > 0
                      ? ListView.builder(
                          itemCount: voucherList.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                                child: voucherCard(index));
                          },
                        )
                      : Container(
                          height: getHeight1(600),
                          child: Center(
                            child: text("No Vouchers Available"),
                          ),
                        )
                  : Container(
                      height: getHeight1(600),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColorName.primaryDark,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Container voucherCard(int i) {
    return Container(
      // height: getHeight1(214),
      width: 100.w,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: colors.secondary2,
          //MyColorName.colorTextFour,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            child: Column(
              children: [
                text("${getString1(voucherList[i].discount)}%",
                    textColor: colors.white1,
                    fontWeight: FontWeight.w600),
                Text(
                  getString1(voucherList[i].message),
                  maxLines: 2,
                  style: TextStyle(fontSize: 18.sp),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(
            height: 10.h,
            child: RotatedBox(
              quarterTurns: 1,
              child: Divider(
                thickness: 1,
                color: Color(0xFFF6F4F4),
              ),
            ),
          ),
          boxWidth(30),
          // new row
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context, voucherList[i]);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: getWidth1(20)),
                      child:
                          text("Apply", textColor: colors.white1))),
              boxHeight(10),
              Container(
                child: Text(
                  'Until ${getString1(voucherList[i].end_date)}',
                  style: TextStyle(fontSize: 7.sp),
                ),
              )
            ],
          ),
          // Container(
          //   transform: Matrix4.translationValues(0.0, 0.0, -60.0),
          //   height: 18.w,
          //   width: 18.w,
          //   // margin: EdgeInsets.symmetric(vertical: 1.h),
          //   decoration:
          //       BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          // )
        ],
      ),
      // cat bg

      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage('images/voucher_bg_cord.png'))),
    );
  }

  goToDetails(context, i) {
/*    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoucherDetails(voucherList[i])));*/
  }
}
