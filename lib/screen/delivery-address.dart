import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/address_model.dart';
import 'package:atticadesign/Model/voucher_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Razorpay.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/screen/voucher_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';
import '../Model/get-delivery-charge-model.dart';
import '../Provider/live_price_provider.dart';
import '../Utils/Common.dart';

class DeliveryAddressPage extends StatefulWidget {
  final GetDeliveryChargeModel getDeliveryChargeModel;
  final bool type;
  String? totalGrams;
   DeliveryAddressPage({
    Key? key,
    required this.getDeliveryChargeModel, required this.type,
    this.totalGrams
  }) : super(key: key);

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  TextEditingController controller = new TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  VoucherModel? model;
  bool loading = true;
  String selectTime = "Schedule Delivery time";
  double subTotal = 0,
      deliveryCharge = 0,
      tax = 0,
      totalAmount = 0,
      tempTotal = 0,
  payAmount = 0,
      proDiscount = 0;
  double? voucher;


  bool saveStatus = true;
  List<String> typeList = ["Home", "Office", "Other"];
  String? selectType;
  List<AddModel> addressList = [];

  double priceRange = 0;
  int? curIndex;
  double gold916Rate = 0 ;
  double gold999Rate = 0 ;
  double total1 = 0;
  double total2 = 0;
  bool goldType = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void totalCalc(BuildContext context){
    var livePrice = Provider.of<LivePriceProvider>(context);
    gold916Rate= double.parse(livePrice.gold1) ;
    gold999Rate= double.parse(livePrice.gold2) ;
    total1 = double.parse(gold916Rate.toString())*
        double.parse(widget.totalGrams.toString());
    total2 = double.parse(gold999Rate.toString())*
        double.parse(widget.totalGrams.toString());
    print("555%${total1.toString()}");
    print("------->${total2.toString()}");
  }

  getTotal() async {
    try {
      Map params = {
        "get_user_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_user_cart"), params);
      setState(() {
        loading = true;
      });
      if (!response['error']) {
        setState(() {
          subTotal = double.parse(response['sub_total'].toString());
          if (response['delivery_charge'] != null) {
            deliveryCharge =
                double.parse(response['delivery_charge'].toString());
          }
          if (response['tax_amount'] != null) {
            tax = double.parse(response['tax_amount'].toString());
          }
          if (response['tax_amount'] != null) {
            tax = double.parse(response['tax_amount'].toString());
          }

          totalAmount = subTotal + deliveryCharge + tax;
          // payAmount = deliveryCharge +
          tempTotal = totalAmount;
        });
      } else {}
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loading = true;
      });
    }
  }

  addVoucher(total, promoCode, model1) async {
    try {
      Map params = {
        "validate_promo_code": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "final_total": subTotal.toString(),
        "promo_code": promoCode.toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "validate_promo_code"), params);

      if (!response['error']) {
        setState(() {
          model = model1;
          voucher =
              double.parse(response['data'][0]['final_discount'].toString());
          totalAmount =
              double.parse(response['data'][0]['final_total'].toString()) +
                  deliveryCharge +
                  tax;
        });
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

  sendRequest() async{

    String gst = widget
        .getDeliveryChargeModel.data!.gstPercentage.toString();
    try {
      Map params = {
        "user_id": App.localStorage.getString("userId").toString(),
        "address": widget
            .getDeliveryChargeModel.data!.address
            .toString(),
        "type": widget.type ? "1" : "2"
            .toString(),
        "amount": widget.getDeliveryChargeModel.data!.amount
            .toString(),
        "delivery_charges": widget
            .getDeliveryChargeModel.data!.deliveryCharges
            .toString(),
        "making_charges": widget
            .getDeliveryChargeModel.data!.makingCharges
            .toString(),
        "gst_percentage":
        gst.toString(),
        "total_amount": widget
            .getDeliveryChargeModel.data!.totalAmount
            .toString(),
        "amount_with_gst": widget
            .getDeliveryChargeModel.data!.amountWithGst
            .toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "submit_product_request"),
          params);

      if (!response['error']) {
        Navigator.pop(context);
        Navigator.pop(context);
        setSnackbar(response['message'], context);

      } else {
        setSnackbar(response['message'], context);
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
    }
  }


  @override
  Widget build(BuildContext context) {
    totalCalc(context);
    // var livePrice = Provider.of<LivePriceProvider>(context);
    // gold916Rate= livePrice.gold1 as double;
    // gold999Rate= livePrice.gold2 as double;

    return Scaffold(
        // backgroundColor: Color(0xFF15654F),
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
              ),),
          title: Text(
            "Order Confirm",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          /* actions: [
            Row(
              children: [
                Icon(Icons.shopping_cart_rounded, color:colors.secondary2),
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
          ],*/
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: getWidth1(49)),
            decoration: BoxDecoration(
            //     image: DecorationImage(
            //   image: AssetImage(
            //     'assets/homepage/vertical.png',
            //   ),
            //   fit: BoxFit.cover,
            // )),
            ),
            child: Column(
              children: [
                boxHeight(16),
                text(
                  "Your Cart Summary",
                  fontFamily: fontMedium,
                  fontSize: 14.sp,
                  textColor: colors.blackTemp,
                ),
                boxHeight(16),
                priceView(),
                boxHeight(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48,
                            bgColor: colors.secondary2,
                            // MyColorName.primaryDark,
                            color: colors.secondary2
                        ),
                        child: Center(
                          child: text("Cancel",
                              fontFamily: fontMedium,
                              fontSize: 18,
                              textColor: colors.blackTemp
                              // MyColorName.colorTextPrimary
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        payAmount = double.parse(widget
                            .getDeliveryChargeModel.data!.deliveryCharges
                            .toString()) + double.parse(widget
                            .getDeliveryChargeModel.data!.deliveryCharges
                            .toString());
                        print("this is pay Amount ${payAmount.toString()}");

                        var a = double.parse(payAmount.toString()) * 100;
                        RazorPayHelper razorHelper = new RazorPayHelper(
                            payAmount.toString(), context, (result) {
                          if (result == "success") {
                            sendRequest();
                          } else {
                            // addOrder();
                          }
                        }, App.localStorage.getString("userId").toString(),
                            "",
                            // widget.gramValue.toString(),
                            false, true);
                        razorHelper.initiated(true, amount: a.toString());

                        // sendRequest();
                      },
                      child: Container(
                        width: getWidth1(283),
                        height: getHeight1(85),
                        decoration: boxDecoration(
                            radius: 48, bgColor: colors.secondary2
                        // MyColorName.primaryDark
                        ),
                        child: Center(
                          child: text("Pay Now",
                              fontFamily: fontMedium,
                              fontSize: 18,
                              textColor: colors.blackTemp
                              //MyColorName.colorTextPrimary
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                boxHeight(30),
              ],
            ),
          )),
        ));
  }

  priceView() {
    return Container(
      width: getWidth1(624),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2.withOpacity(0.4)
        //MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth1(29), vertical: getHeight1(32)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Total grams : ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹${widget.getDeliveryChargeModel.data!.amount}",
                // "${widget.totalGrams} gms",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Making Charge : ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹${widget.getDeliveryChargeModel.data!.makingCharges}",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          // boxHeight(10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     text(
          //       "GST Charge : ",
          //       fontSize: 10.sp,
          //       fontFamily: fontRegular,
          //     ),
          //     text(
          //       "${widget.getDeliveryChargeModel.data!.gstPercentage}%",
          //       fontSize: 10.sp,
          //       fontFamily: fontBold,
          //     ),
          //   ],
          // ),
          boxHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Delivery Charges : ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "₹${widget.getDeliveryChargeModel.data!.deliveryCharges}",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),
          boxHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Sub Amount : ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              text(
                "${widget.getDeliveryChargeModel.data!.totalAmount}",
                fontSize: 10.sp,
                fontFamily: fontBold,
              ),
            ],
          ),

          // boxHeight(10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     text(
          //       "Total Amount With GST Charge : ",
          //       fontSize: 10.sp,
          //       fontFamily: fontRegular,
          //     ),
          //     text(
          //       "${widget.getDeliveryChargeModel.data!.amountWithGst}",
          //       fontSize: 10.sp,
          //       fontFamily: fontBold,
          //     ),
          //   ],
          // ),,

          boxHeight(22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(
                "Address: ",
                fontSize: 10.sp,
                fontFamily: fontRegular,
              ),
              Expanded(
                child: Text(" ${widget.getDeliveryChargeModel.data!.address}",
                    maxLines: 4, overflow: TextOverflow.ellipsis),
              )
            ],
          ),



        ],
      ),
    );
  }

  voucherView() {
    return Container(
      height: getHeight1(144),
      width: getWidth1(622),
      decoration: boxDecoration(
        radius: 15,
        bgColor: MyColorName.colorTextFour.withOpacity(0.3),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth1(16),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/buydigitalgold/coupon.png",
            width: getWidth1(79),
            height: getHeight1(54),
            fit: BoxFit.fill,
          ),
          boxWidth(20),
          Container(
              child: text("You have a Voucher",
                  fontSize: 10.sp, fontFamily: fontRegular)),
          boxWidth(20),
          InkWell(
            onTap: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VoucherListView()));
              print(result);
              if (result != null) {
                setState(() {
                  model = null;
                  voucher = null;
                });
                addVoucher(tempTotal, result.promo_code, result);
              }
            },
            child: Container(
              width: getWidth1(160),
              height: getHeight1(55),
              decoration:
                  boxDecoration(radius: 48, bgColor: MyColorName.primaryDark),
              child: Center(
                child: text("See All",
                    fontFamily: fontMedium,
                    fontSize: 10.sp,
                    textColor: MyColorName.colorTextPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
