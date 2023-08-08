import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/productDetails.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Model/category_model.dart';
import '../Model/sub_categori_goldorsilver.dart';
import '../Model/sub_category_model.dart';
import '../Utils/widget.dart';

class jewerry extends StatefulWidget {
  const jewerry({Key? key}) : super(key: key);

  @override
  State<jewerry> createState() => _jewerryState();
}

class _jewerryState extends State<jewerry> {
  String type = "48";
  bool isDone = false;
  String a = "All";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productSubCategoriesCategoriesWiseListJewellery(catGold).then((value) => {
          if (value != null)
            setState(() {
              isDone = true;
            })
        });
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = true;
  List<CategoryModel> catList = [];
  bool fav = false;

  addFav(vId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "product_id": vId,
          "user_id": App.localStorage.getString("userId").toString(),
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "add_to_favorites"), data);
        print(response);
        setState(() {
          fav = false;
        });
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          fav = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        fav = false;
      });
    }
  }

  addFavRemove(vId) async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "product_id": vId,
          "user_id": App.localStorage.getString("userId").toString(),
        };
        Map response = await apiBase.postAPICall(
            Uri.parse(baseUrl + "remove_from_favorites"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          fav = false;
        });
        setSnackbar(msg, context);
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          fav = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        fav = false;
      });
    }
  }

  String catGold = "54", sub = "", catSilver = "55", subSilver = "";
  String tapIndex = "0";
  int isSelected = 0;
  bool isGold = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage(
              //     'assets/homepage/vertical.png',
              //   ),
              //   fit: BoxFit.cover,
              // )
              ),
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            color: colors.blackTemp,
                            //Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                         // margin: EdgeInsets.only(left: 20, right: 10),
                          child: isDone
                              ? FutureBuilder(
                                  future:
                                      productSubCategoriesCategoriesWiseListJewellery(
                                          isGold ? catGold : catSilver),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    SubCategoriGoldorsilver model =
                                        snapshot.data;
                                    List<String> listCat = [];
                                    isDone = true;
                                    if (model != null &&
                                        model.data != null &&
                                        model.data!.length > 0) {
                                      model.data!.forEach((element) {
                                        listCat.add(element.name.toString());
                                      });
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return model.error == false
                                            ? listCat.length > 0
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                    child:
                                                        DropdownButton<String>(
                                                      value: a,
                                                      dropdownColor: Colors.black45,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      elevation: 16,
                                                      style: const TextStyle(
                                                         color: colors.blackTemp,),
                                                      underline:
                                                          SizedBox.shrink(),
                                                      items: listCat
                                                          .map((fc) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                child: Container(
                                                                  margin: EdgeInsets.only(left: 60),
                                                                  child: Center(
                                                                      child: Text(
                                                                    fc,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                      color: colors.blackTemp,
                                                                    ),
                                                                  )),
                                                                ),
                                                                value: fc,
                                                              ))
                                                          .toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          a = newValue!;
                                                          int index =
                                                              listCat.indexOf(
                                                                  a.toString());
                                                          if (index != 0) {
                                                            _getData(
                                                                model
                                                                    .data![
                                                                        index]
                                                                    .products![
                                                                        index]
                                                                    .categoryId
                                                                    .toString(),
                                                                model
                                                                    .data![
                                                                        index]
                                                                    .products![
                                                                        index]
                                                                    .subCategoryId
                                                                    .toString(),
                                                                topRated,
                                                                orderType);
                                                          }

                                                          setState(() {
                                                            topRated = "0";

                                                            isSelected = index;
                                                            if (isGold) {
                                                              if (index == 0) {
                                                                productSubCategoriesCategoriesWiseListJewellery(
                                                                    catGold);
                                                              } else {
                                                                catGold = model
                                                                    .data![
                                                                        index]
                                                                    .products![
                                                                        index]
                                                                    .categoryId
                                                                    .toString();
                                                              }
                                                            } else {
                                                              if (index == 0) {
                                                                productSubCategoriesCategoriesWiseListJewellery(
                                                                    catSilver);
                                                              } else {
                                                                catSilver = model
                                                                    .data![
                                                                        index]
                                                                    .products![
                                                                        index]
                                                                    .categoryId
                                                                    .toString();
                                                              }
                                                            }
                                                            sub = index != 0
                                                                ? model
                                                                    .data![
                                                                        index]
                                                                    .products![
                                                                        index]
                                                                    .subCategoryId
                                                                    .toString()
                                                                : "";
                                                            setState(() {});
                                                          });
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : SizedBox()
                                            : SizedBox();
                                      } else if (snapshot.hasError) {
                                        return Icon(Icons.error_outline);
                                      }
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox();
                                    }
                                    return Container(
                                      width: 40,
                                      height: 40,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ),
                                      ),
                                    );
                                  })
                              : SizedBox(),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            bottomSheet();
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset(
                                'assets/buydigitalgold/filter.png',
                                height: 20,
                   color: colors.blackTemp,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Filters',
                                style: TextStyle(
                                  color: colors.blackTemp,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /*   Container(
                      height: 50,
                      child: FutureBuilder(
                          future: productSubCategoriesCategoriesWiseListJewellery(
                              isGold ? catGold : catSilver),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            SubCategoriGoldorsilver model = snapshot.data;
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                return model.error == false
                                    ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: model.data!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, index) {
                                      return Container(
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            color: isSelected == index
                                                ? Colors.green
                                                :colors.secondary2,
                                            border: Border.all(
                                                color: isSelected == index
                                                    ? Colors.green
                                                    :colors.secondary2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7.0) //
                                            ),
                                          ),
                                          margin: EdgeInsets.all(8),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if(index != 0){
                                                _getData(
                                                    model
                                                        .data![index]
                                                        .products![index]
                                                        .categoryId
                                                        .toString(),
                                                    model
                                                        .data![index]
                                                        .products![index]
                                                        .subCategoryId
                                                        .toString(), topRated, orderType);
                                              }

                                              setState(() {
                                                topRated = "0";

                                                isSelected = index;
                                                if (isGold) {
                                                  if (index == 0) {
                                                    productSubCategoriesCategoriesWiseListJewellery(catGold);
                                                  } else {
                                                    catGold = model
                                                        .data![index]
                                                        .products![index]
                                                        .categoryId
                                                        .toString();
                                                  }
                                                } else {
                                                  if (index == 0) {
                                                    productSubCategoriesCategoriesWiseListJewellery(catSilver);
                                                  } else {
                                                    catSilver = model
                                                        .data![index]
                                                        .products![index]
                                                        .categoryId
                                                        .toString();
                                                  }
                                                }
                                                sub = index != 0
                                                    ? model
                                                    .data![index]
                                                    .products![index]
                                                    .subCategoryId
                                                    .toString()
                                                    : "";
                                                setState(() {});
                                              });
                                            },
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4),
                                                child: Text(
                                                  "${model.data![index].name.toString()}",
                                                  style:
                                                  TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ));
                                    })
                                    : Container(
                                  child: Text("No Data"),
                                );
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              }
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                width: 40,
                                height: 40,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1,
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: 40,
                              height: 40,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              ),
                            );
                          }),
                    ),*/

                Expanded(
                  child: FutureBuilder(
                      future: _getData(isGold ? catGold : catSilver, sub,
                          topRated, orderType),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data != null) {
                            SubCategoryModel model = snapshot.data;
                            List<SubCategoryModel>? lista = [];
                            model.product!.forEach((element) {
                              lista.add(model);
                            });
                            return model.error == false
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 50),
                                    width: getWidth(350),
                                    child: lista.length > 0
                                        ? GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 250,
                                                    childAspectRatio: 0.85,
                                                    crossAxisSpacing: 10,
                                                    mainAxisSpacing: 8),
                                            itemCount: lista.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return InkWell(
                                                onTap: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductDetailsScreen(
                                                                  model
                                                                      .product![
                                                                          index]
                                                                      .id, isGold)));
                                                },
                                                child: Container(
                                                  decoration: boxDecoration(
                                                    radius: 24.sp,
                                                    bgColor: colors.white1,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: commonHWImage(
                                                            model
                                                                .product![index]
                                                                .image,
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                5,
                                                            MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width,
                                                            "",
                                                            context,
                                                            "assets/homepage/gold.png"),
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .only(
                                                            topLeft: const Radius
                                                                .circular(10.0),
                                                            topRight: const Radius
                                                                .circular(10.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 4,
                                                                  horizontal:
                                                                      4),
                                                          width:
                                                              double.infinity,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              text(
                                                                  getString1(model
                                                                      .product![
                                                                          index]
                                                                      .name
                                                                      .toString()),
                                                                  fontFamily:
                                                                      fontMedium,
                                                                  fontSize:
                                                                      9.sp),
                                                              text(
                                                                "₹ " +
                                                                    getString1(model
                                                                        .product![
                                                                            index]
                                                                        .variants![
                                                                            0]
                                                                        .specialPrice
                                                                        .toString()),
                                                                fontFamily:
                                                                    fontMedium,
                                                                fontSize: 12.sp,
                                                                textColor: Color(
                                                                    0xffF1D459),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 1,
                                              ),
                                            ),
                                          ),
                                  )
                                : Container(
                                    child: Text("No Data"),
                                  );
                          } else if (snapshot.hasError ||
                              snapshot.data == null) {
                            return Icon(Icons.error_outline);
                          }
                        }
                        return Container(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          ),
                        );
                      }),
                ),
                // SizedBox(
                //   height: 70,
                // )
              ]),
            ),
          ],
        ),
      ),
    ));
  }

  var typeSelect = "0";
  bool isCash = false;

  void bottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Color(0xff0C3B2E),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Text(
                  "Filter By",
                  style: TextStyle(color: Colors.orange),
                ),
                trailing: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    orderType = "ASC";
                    topRated = "0";
                    _getData(catGold, sub, topRated, orderType);
                    Navigator.pop(context);
                  });
                  /*setState(() {
                    typeSelect = "1";
                    isCash = false;
                    Navigator.pop(context);
                  });*/
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                  child: Text(
                    "Price low to high",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    orderType = "DESC";
                    topRated = "0";
                    _getData(catGold, sub, topRated, orderType);
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Price high to low",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    topRated = "1";
                    _getData(catGold, sub, topRated, orderType);
                    Navigator.pop(context);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Popular Items",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }

  String orderType = "ASC";
  String topRated = "0";

  Future<SubCategoryModel?> _getData(cat, sub, topRated, orderType) async {
    SubCategoryModel? a =
        await productSubCategoriesCategoriesWise(cat, sub, orderType, topRated);
    if (a != null && a.product != null) {
      return a;
    }
    return null;
  }
}
