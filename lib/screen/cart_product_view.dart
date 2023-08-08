
import 'package:atticadesign/Helper/newproduct.dart';
import 'package:atticadesign/Model/cart_model.dart';
import 'package:atticadesign/Model/category_model.dart';
import 'package:atticadesign/Model/order_model.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';


class CartProductView extends StatelessWidget {
  VoidCallback onRemove;
  VoidCallback onAdd;
  VoidCallback onTap, onDelete;
  bool value;
  CartData model;
  CartProductView(
      this.model,this.onRemove, this.onAdd, this.onTap, this.onDelete, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(330),
      height: getHeight(130),
      margin: EdgeInsets.only(bottom: getHeight(10)),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2
        //MyColorName.colorTextFour,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(10), vertical: getHeight(10)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: commonHWImage(
                    model.productDetails![0].image ?? "",
                    100.0,
                    100.0,
                    "images/product/product0.png",
                    context,
                    "images/product/product0.png"),
              ),
              Container(
                width: getWidth(220),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(getString1(model.productDetails?[0].name.toString() ?? ""),
                            fontSize: 10.sp, fontFamily: fontRegular,textColor: colors.blackTemp ),
                        InkWell(
                          onTap: onDelete,
                          child: Image.asset(
                            "assets/delete.png",
                            width: getWidth(20),
                            height: getWidth(20),
                            color: colors.blackTemp
                            ,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        text("₹ ${model.productDetails?[0].variants?[0].specialPrice.toString() ?? ""}",
                            fontSize: 14.sp, fontFamily: fontBold),
                        boxWidth(10),
                      /*  Image.asset(
                          "images/star.png",
                          width: getHeight(20),
                          height: getHeight(20),
                        ),
                        boxWidth(5),
                        text(model.productDetails![0].average_rating.toString()!="null"&&model.items[0].average_rating!="0"?parseDouble(model.items[0].average_rating):"4.5",
                            fontSize: 12.sp,
                            fontFamily: fontBold,
                            textColor: MyColorName.colorTextFour),*/
                      ],
                    ),
                    if(model.size != null && model.size.toString() != "0")
                      text("Size ${model.size.toString() ?? ""} ", fontSize: 10.sp, fontFamily: fontRegular),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              text("Wt. : ", fontSize: 10.sp, fontFamily: fontRegular),
                              text("${model.productDetails?[0].weight.toString() ?? ""} gm", fontSize: 10.sp, fontFamily: fontRegular),
                            ],
                          ),
                          Container(
                            width: getWidth(125),
                            height: getHeight(40),
                            decoration: boxDecoration(
                              radius: 10,
                              bgColor: colors.secondary2,
                            ),
                            child: parseInt(model.qty)>0
                                ?Row(
                              children: [
                                InkWell(
                                  onTap: onRemove,
                                  child: Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      radius: 10,
                                      bgColor: colors.blackTemp,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.remove,size: 20.sp,
                                      color: colors.secondary2,),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      bgColor: colors.secondary2,
                                      //MyColorName.colorBg1,
                                      radius: 0,
                                    ),
                                    child: Center(
                                      child: text("${model.qty?.toString() ?? ""}",
                                          fontFamily: fontBold,
                                          fontSize: 12.sp,
                                          textColor: colors.blackTemp),
                                    )),
                                InkWell(
                                  onTap: onAdd,
                                  child: Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      radius: 10,
                                      bgColor: colors.blackTemp,
                                      //MyColorName.colorIcon,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,size: 20.sp,
                                      color: colors.secondary2,),
                                    ),
                                  ),
                                ),
                              ],
                            ):InkWell(
                              onTap: onAdd,
                              child: Container(
                                height: getHeight(40),
                                width: getWidth(40),
                                child: Center(
                                  child: text("ADD",
                                      fontSize: 10.sp,
                                      fontFamily:
                                      fontMedium,
                                      textColor: colors.secondary2),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          !value?Center(child: CircularProgressIndicator(color: MyColorName.primaryDark,)):SizedBox()
        ],
      ),
    );
  }
}
class CartProductView1 extends StatelessWidget {
  VoidCallback onRemove;
  VoidCallback onAdd;
  VoidCallback onTap, onDelete;
  bool value;
  ProductModel model;
  CartProductView1(
      this.model,this.onRemove, this.onAdd, this.onTap, this.onDelete, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(330),
      height: getHeight(130),
      margin: EdgeInsets.only(bottom: getHeight(10)),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2
        //MyColorName.colorTextFour,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(10), vertical: getHeight(10)),
      child: Stack(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: commonHWImage(
                      model.image,
                      110.0,
                      110.0,
                      "images/product/product0.png",
                      context,
                      "images/product/product0.png"),
                ),
                Container(
                  width: getWidth(210),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          text(getString1(model.name.toString()),
                              fontSize: 10.sp, fontFamily: fontRegular,textColor: colors.blackTemp
                            //  MyColorName.colorIcon
                          ),
                          InkWell(
                            onTap: onDelete,
                            child: Image.asset(
                              "assets/delete.png",
                              width: getWidth(20),
                              height: getWidth(20),
                              color: MyColorName.colorEdit,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          text("₹"+model.variants![0].price.toString(), fontSize: 14.sp, fontFamily: fontBold),
                        ],
                      ),
                      boxHeight(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              text("Wt. : ", fontSize: 10.sp, fontFamily: fontRegular),
                              text(model.weight.toString()+"gm", fontSize: 10.sp, fontFamily: fontRegular),
                            ],
                          ),
                          Container(
                            width: getWidth(124),
                            height: getHeight(40),
                            decoration: boxDecoration(
                              radius: 10,
                              bgColor: colors.secondary2
                              //MyColorName.colorIcon,
                            ),
                            child: parseInt(model.variants![0].cartCount)>0
                                ?Row(
                              children: [
                                InkWell(
                                  onTap: onRemove,
                                  child: Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      radius: 10,
                                      bgColor: colors.blackTemp,
                                      //MyColorName.colorIcon,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.remove,size: 20.sp,
                                      color: colors.secondary2,),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      bgColor: colors.secondary2,
                                      //MyColorName.colorBg1,
                                      radius: 0,
                                    ),
                                    child: Center(
                                      child: text(model.variants![0].cartCount.toString(),
                                          fontFamily: fontBold,
                                          fontSize: 12.sp,
                                          textColor: colors.blackTemp
                                         // MyColorName.colorTextPrimary
                                      ),
                                    )),
                                InkWell(
                                  onTap: onAdd,
                                  child: Container(
                                    height: getHeight(40),
                                    width: getWidth(40),
                                    decoration: boxDecoration(
                                      radius: 10,
                                      bgColor: colors.blackTemp
                                      //MyColorName.colorIcon,
                                    ),
                                    child: Center(
                                      child: Icon(Icons.add,size: 20.sp,
                                      color: colors.secondary2,),
                                    ),
                                  ),
                                ),
                              ],
                            ):InkWell(
                              onTap: onAdd,
                              child: Container(
                                height: getHeight(40),
                                width: getWidth(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colors.blackTemp
                                ),
                                child: Center(
                                  child: text("ADD",
                                      fontSize: 10.sp,
                                      fontFamily:
                                      fontMedium,
                                      textColor: colors.secondary2,
                                      // MyColorName
                                      //     .colorTextPrimary
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*parseInt(model.variants[0].cart_count)<1?InkWell(
                        onTap: onAdd,
                        child: Container(
                          width: getWidth(152),
                          decoration: boxDecoration(
                            radius: 10,
                            bgColor: MyColorName.primaryDark,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: getHeight(49),
                                width: getWidth(49),
                                decoration: boxDecoration(
                                  radius: 10,
                                  bgColor: MyColorName.primaryDark,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "images/our_gurantees/add.png",
                                    height: getHeight(18),
                                    width: getHeight(18),
                                  ),
                                ),
                              ),
                              Container(
                                  child: Center(
                                    child: text("Add".toString(),
                                        fontFamily: fontBold,
                                        fontSize: 12.sp,
                                        textColor: MyColorName.colorTextFour),
                                  )),
                            ],
                          ),
                        ),
                      ):
                      Container(
                        width: getWidth(152),
                        decoration: boxDecoration(
                          radius: 10,
                          bgColor: MyColorName.primaryDark,
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: onAdd,
                              child: Container(
                                height: getHeight(49),
                                width: getWidth(49),
                                decoration: boxDecoration(
                                  radius: 10,
                                  bgColor: MyColorName.primaryDark,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "images/our_gurantees/add.png",
                                    height: getHeight(18),
                                    width: getHeight(18),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: getHeight(49),
                                width: getWidth(49),
                                decoration: boxDecoration(
                                  bgColor: MyColorName.colorTextFour,
                                radius: 0,
                                ),
                                child: Center(
                                  child: text(model.variants[0].cart_count.toString(),
                                      fontFamily: fontBold,
                                      fontSize: 12.sp,
                                      textColor: MyColorName.colorTextPrimary),
                                )),
                            InkWell(
                              onTap: onRemove,
                              child: Container(
                                height: getHeight(49),
                                width: getWidth(49),
                                decoration: boxDecoration(
                                  radius: 10,
                                  bgColor: MyColorName.primaryDark,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "images/our_gurantees/remove.png",
                                    height: getHeight(18),
                                    width: getHeight(18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
          !value?Center(child: CircularProgressIndicator(color: MyColorName.primaryDark,)):SizedBox()

        ],
      ),
    );
  }
}
class OrderView extends StatelessWidget {

  VoidCallback onTap;
  OrderModel model;
  OrderView(
      this.model, this.onTap,);

  @override
  Widget build(BuildContext context) {
    Color back;

    if ((model.orderItems![0].activeStatus!) == DELIVERD)
      back = Colors.green;
    else if ((model.orderItems![0].activeStatus!) == SHIPED)
      back = Colors.orange;
    else if ((model.orderItems![0].activeStatus!) == CANCLED ||
        model.orderItems![0].activeStatus! == RETURNED)
      back = Colors.red;
    else if ((model.orderItems![0].activeStatus!) == PROCESSED)
      back = Colors.indigo;
    else if (model.orderItems![0].activeStatus! == WAITING)
      back = Colors.black;
    else
      back = Colors.cyan;
    return Container(
      width: getWidth(330),
      height: getHeight(130),
      margin: EdgeInsets.only(bottom: getHeight(10)),
      decoration: boxDecoration(
        radius: 15,
        bgColor: colors.secondary2,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: getWidth(10), vertical: getHeight(10)),
      child:   InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: commonHWImage(
                  model.orderItems![0].image,
                  110.0,
                  110.0,
                  "images/product/product0.png",
                  context,
                  "images/product/product0.png"),
            ),
            Container(
              width: getWidth(210),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: text(getString1(model.name.toString()),
                            fontSize: 14.sp, fontFamily: fontRegular,textColor: colors.blackTemp),
                      ),
                      Column(
                        children: [
                          Icon(Icons.check_circle,color: back,),
                          text(model.orderItems![0].activeStatus.toString(), fontSize: 8.sp, fontFamily: fontRegular,textColor: back),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      text("₹"+model.totalPayable.toString(),
                     // orderItems![0].price.toString(),
                          fontSize: 14.sp, fontFamily: fontMedium),
                    ],
                  ),
                  boxHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          text("Qty. : ", fontSize: 10.sp, fontFamily: fontRegular),
                          text(model.orderItems![0].quantity.toString(), fontSize: 10.sp, fontFamily: fontRegular),
                        ],
                      ),
                      text(DateFormat("dd-MM-yyyy").format(DateTime.parse(model.dateAdded!)),
                          fontSize: 10.sp,
                          fontFamily:
                          fontMedium,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}