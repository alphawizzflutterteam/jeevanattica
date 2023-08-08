import 'dart:async';

import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Helper/newproduct.dart';
import 'package:atticadesign/Model/category_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/colors.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/Utils/widget.dart';
import 'package:atticadesign/screen/cart_product_view.dart';
import 'package:flutter/material.dart';

import '../Utils/Common.dart';
import '../notifications.dart';
import 'Color.dart';
import 'myCart.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  int totalCount = 0;
  int? currentIndex;
  String productImage = "", productName = "";
  bool loading = true;
  bool loadingWish = false;
  List<ProductModel> productList = [];

  getWishList() async {
    try {
      setState(() {
        loadingWish = false;
        productList.clear();
      });
      Map params = {
        "get_favorites": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "limit": "10",
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(baseUrl + "get_favorites"), params);
      setState(() {
        loadingWish = true;
      });
      if (!response['error']) {
        for (var v in response['data']) {
          setState(() {
            productList.add(new ProductModel.fromJson(v));
          });
        }
      } else {
        setState(() {
          likeCount = 0;
        });
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {
        loadingWish = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishList();
  }

  void addCart(i) {
    Map data1 = {};
    Map data = {};
    int count = parseInt(productList[i].variants![0].cartCount);
    /*if(count>=parseInt(productList[i].variants![0].stock)){
      setSnackbar("Only ${productList[i].variants![0].stock} Stock Available", context);
      return;
    }*/
    setState(() {
      count++;
      productList[i].variants![0].cartCount = count.toString();
      totalCount++;
    });
    data = {
      "add_to_cart": "1",
      "user_id": App.localStorage.getString("userId").toString(),
      "product_id": productList[i].variants![0].id,
      "product_variant_id": productList[i].variants![0].id,
      "qty": productList[i].variants![0].cartCount,
    };
    callApi("manage_cart", data, i);
  }

  void removeCart(i) {
    Map data1 = {};
    Map data = {};
    int count = parseInt(productList[i].variants![0].cartCount);
    if (count == 1) {
      setState(() {
        count--;
        productList[i].variants![0].cartCount = count.toString();
        totalCount--;
      });

      data1 = {
        "remove_from_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "product_variant_id": productList[i].variants![0].id,
        "qty": productList[i].variants![0].cartCount,
      };
    } else {
      setState(() {
        count--;
        productList[i].variants![0].cartCount = count.toString();
        totalCount--;
      });
      data1 = {
        "add_to_cart": "1",
        "user_id": App.localStorage.getString("userId").toString(),
        "product_id": productList[i].variants![0].id,
        "product_variant_id": productList[i].variants![0].id,
        "qty": productList[i].variants![0].cartCount,
      };
      print("ok");
    }
    callApi("manage_cart", data1, -1);
  }

  void favorite(i) {
    Map data;
    data = {
      "remove_from_favorites": "1",
      "user_id": App.localStorage.getString("userId").toString(),
      "product_id": productList[i].variants![0].productId,
    };
    setState(() {
      productList[i].isFavorite = 1;
    });

    callApi("remove_from_favorites", data, -1);
  }

  void callApi(String url, Map data, int i) async {
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        setState(() {
          loading = false;
        });
        Map response =
            await apiBase.postAPICall(Uri.parse(baseUrl + url), data);
        setState(() {
          loading = true;
        });
        if (!response['error']) {
          if (url == "remove_from_favorites") {
            getWishList();
          }
        } else {
          /*if(i!=-1){
            int count = parseInt(productList[i].variants![0].cartCount);
            count--;
            productList[i].variants![0].cartCount = count.toString();
            totalCount--;

            setSnackbar(response['message'], context);
          }*/

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = true;
        });
      }
    } else {
      setSnackbar("No Internet Available", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: Color(0xff0F261E),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colors.primaryNew,
          //Color(0xff15654F),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
            ),
          ),
          title: Text(
            "Favourite list",
            style: TextStyle(
              color: colors.black54,
              fontSize: 20,
            ),
          ),
          actions: [
            Row(
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyCart()));
                    },
                    child: Icon(Icons.shopping_cart_outlined, color:colors.secondary2)),
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
                      child: Icon(Icons.notification_add_outlined,
                          color:colors.secondary2)),
                ),
              ],
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: getWidth(10)),
          child: Column(
            children: [
              boxHeight(10),
              loadingWish
                  ? productList.length > 0
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: productList.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CartProductView1(
                                  productList[index],
                                  () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    removeCart(index);
                                  },
                                  () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    addCart(index);
                                  },
                                  () async {

                                  },
                                  () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                    favorite(index);
                                  },
                                  currentIndex == index ? loading : true,
                                );
                              }),
                        )
                      : Expanded(
                          child: Center(
                            child: text("No Favorites Available"),
                          ),
                        )
                  : Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColorName.primaryDark,
                        ),
                      ),
                    ),
              boxHeight(20),
              productList.length > 0 ?
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyCart()));
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                    decoration: BoxDecoration(
                        color:colors.secondary2,
                        border: Border.all(
                          color:colors.secondary2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    child: Center(child: Text("Buy Now", style: TextStyle(color: Colors.white, fontSize: 18)),)
                ),
              )
              : SizedBox.shrink(),
            ],
          ),
        ),
    /*bottomNavigationBar: GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyCart()));
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color:colors.secondary2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Center(child: Text("Buy Now", style: TextStyle(color: Colors.white, fontSize: 18)),)
      ),
    ),*/
    );
  }
}
