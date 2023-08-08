import 'dart:async';

import 'package:atticadesign/notifications.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/address_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';

import '../Helper/Color.dart';
import 'new_address.dart';

class AddressList extends StatefulWidget {
  bool check;
  bool appBar;

  AddressList(this.check,this.appBar);

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  bool saveStatus = true;
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<AddModel> addressList = [];
  getAddress() async {
    try {
      setState(() {
        addressList.clear();
        saveStatus = false;
      });
      Map params = {
        "get_addresses": "1",
        "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response =
          await apiBase.postAPICall(Uri.parse(baseUrl + "get_address"), params);
      print(params.toString());
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            if(v['type']!=""){
              addressList.add(new AddModel.fromJson(v));
            }
          });
        }
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  removeAddress(id) async {
    try {
      setState(() {
        saveStatus = false;
      });
      Map params = {
        "delete_address": "1",

        "id": id.toString(),
      };
      Map response =
      await apiBase.postAPICall(Uri.parse(baseUrl + "delete_address"), params);
      setState(() {
        saveStatus = true;
      });
      if (!response['error']) {
        getAddress();
      }
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          fontSize: 18, textColor: Colors.yellow,
          msg: "Address removed successfully");
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        saveStatus = true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context,true);
        return Future.value();
      },
      child: Scaffold(
     //   backgroundColor: Color(0xFF0F261E),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primaryNew,
          //Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context,true);
            },
            child: Icon(
              Icons.arrow_back,
              color: colors.secondary2,
            ),
          ),
          title: Text(
            "My Address",
            style: TextStyle(
              color: colors.white1,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
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
        body: Container(
          height: 100.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                top: getHeight1(30),
                child: Container(
                  width: getWidth1(624),
                  height: getHeight1(940),
                  child: saveStatus
                      ? addressList.length > 0
                      ? ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async{
                            if(widget.check){
                              await App.init();
                              setState(() {
                                addressId = addressList[index].id.toString();
                                App.localStorage.setString("addressId", addressId);
                                App.localStorage.setString("type", addressList[index].type.toString());
                              });
                              Navigator.pop(context,addressList[index].type);
                            }else{
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => AddNewAddress(addressModel:addressList[index])));
                              if (result == "yes") {
                                getAddress();
                              }
                            }

                          },
                          child: Container(
                              width: getWidth1(624),
                              margin:
                              EdgeInsets.only(bottom: getHeight1(20)),
                              decoration: boxDecoration(
                                  bgColor: colors.secondary2.withOpacity(0.4),
                                  // MyColorName.colorTextFour
                                  //     .withOpacity(0.3),
                                  radius: 10,
                                  color: colors.blackTemp),
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth1(30),
                                  vertical: getHeight1(20)),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: getHeight1(128),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            text(addressList[index].type.toString(),
                                                fontSize: 10.sp,
                                                fontFamily: fontBold),
                                            boxWidth(10),
                                            widget.check?InkWell(
                                              onTap: ()async{
                                                var result = await Navigator.push(context,
                                                    MaterialPageRoute(builder: (context) => AddNewAddress(addressModel:addressList[index])));
                                                if (result == "yes") {
                                                  getAddress();
                                                }
                                              },
                                              child: text("Edit",
                                                  fontSize: 10.sp,
                                                  textColor: MyColorName.primaryLite,
                                                  fontFamily: fontBold,under: true),
                                            ):SizedBox(),
                                          ],
                                        ),
                                        boxHeight(15),
                                        Container(
                                          width: getWidth1(460),
                                          child: text(
                                              addressList[index].address.toString()+" "+addressList[index].landmark.toString()+","+addressList[index].country.toString(),
                                              fontSize: 8.sp,
                                              fontFamily: fontRegular,
                                              maxLine: 3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      removeAddress(addressList[index].id);
                                    },
                                    child: Image.asset(
                                      "assets/delete.png",
                                      width: getWidth1(30),
                                      height: getWidth1(30),
                                      color: colors.blackTemp,
                                    ),
                                  ),
                                  widget.check?Icon(
                                    addressId==addressList[index].id?Icons.radio_button_checked:Icons.radio_button_off,
                                    color: MyColorName.colorIcon,
                                  ): Icon(
                                    Icons.edit,
                                    color: colors.blackTemp
                                  ),

                                ],
                              )),
                        );
                      })
                      : Center(
                    child: text("No Address Available",
                        textColor: colors.blackTemp),
                  )
                      : Center(
                    child: CircularProgressIndicator(
                      color: MyColorName.primaryDark,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: getHeight1(50),
                child: InkWell(
                  onTap: () async {
                    var result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddNewAddress(addressModel: null,)));
                    if (result == "yes") {
                      getAddress();
                    }
                  },
                  child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      color: MyColorName.primaryDark,
                      dashPattern: [3, 3],
                      child: Container(
                        width: getWidth1(622),
                        height: getHeight1(75),
                        child: Center(
                          child: text(
                            "Add Address",
                            fontFamily: fontMedium,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
