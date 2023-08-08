import 'dart:convert';
import 'dart:math';

import 'package:atticadesign/Helper/sellSilverModel.dart';
import 'package:atticadesign/Model/pruchaseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Helper/transation_mode.dart';
import '../Model/AddToCardModel.dart';
import '../Model/CatelogDetailsModel.dart';
import '../Model/EditProfileModel.dart';
import '../Model/GetCartModel.dart';
import '../Model/GetCouponModel.dart';
import '../Model/GetGoldCoinModel.dart';
import '../Model/GetNotificationModel.dart';
import '../Model/GetWishListModel.dart';
import '../Model/NumberModel.dart';
import '../Model/PrivacyPolicy.dart';
import '../Model/ProductDetailsByIdModel.dart';
import '../Model/UserDetailsModel.dart';
import '../Model/banner_model.dart';
import '../Model/homeSlider_model.dart';
import '../Model/login_model.dart';
import '../Model/productDetails_model.dart';
import '../Model/registrtion_model.dart';
import '../Model/sub_categori_goldorsilver.dart';
import '../Model/sub_category_model.dart';
import '../Model/termsandConditions_model.dart';
import '../Model/transaction_model.dart';
import '../Model/withdraw_history.dart';
import '../Utils/Common.dart';
import '../Utils/constant.dart';
import '../Utils/withdrawmodel.dart';

//TextEditingController tokenCtrl = TextEditingController();
String baseUrl1 = "https://developmentalphawizz.com/jeevan/app/v1/api/";
    // "https://alphawizztest.tk/Atticadigitamarketing/app/v1/api/";
String razorPayKey = "rzp_test_CpvP0qcfS4CSJD";

Future<RegistrtionModel?> registration(name, mobile, gender, age) async {
  var headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NTMxMjA4MDgsImlzcyI6ImVzaG9wIiwiZXhwIjoxNjUzMTIyNjA4fQ.pZicHCyfhwwor-RsPF9H0u0CXZzevBy0u_JA3Vk1GsI',
  };
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'register'));
  request.fields.addAll({
    'name': '$name',
    'mobile': '$mobile',
    'gender': 'male',
    'age': '12',
    'email': 'alpdha@gmail.com',
    'password': '12345678'
  });

  print(request);
  print(request.fields);
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return RegistrtionModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<LoginModel?> login(mobile) async {
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'login'));
  request.fields.addAll({'mobile': '$mobile'});
  print(request);
  print(request.fields.toString() + "ssss");
  // request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return LoginModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<PrivacyPolicy?> privacyPolicy() async {
  var headers = {
    'Cookie':
        'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'get_privacy_policy'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return PrivacyPolicy.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<CatelogDetailsModel?> getCatelog() async {
  var headers = {
    'Cookie':
    'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('POST', Uri.parse(baseUrl1 + 'get_catelogs'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return CatelogDetailsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<BannerModel?> getBaneerHomeScreen() async {
  var headers = {
    'Cookie':
    'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'get_slider_images'));
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return BannerModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<TermsandConditionsModel?> termsandConditions() async {
  var headers = {
    'Cookie':
        'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
  };
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'terms_conditions'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TermsandConditionsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<HomeSliderModel?> homeSlider() async {
  var request = http.Request('GET', Uri.parse(baseUrl1 + 'get_slider_images'));

  // request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return HomeSliderModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<ProductDetailsModel?> productDetails() async {
  var headers = {
    'Cookie':
        'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_productdetails'));
  request.fields
      .addAll({'id': App.localStorage.getString("userId").toString()});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return ProductDetailsModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<SubCategoryModel?> productSubCategoriesCategoriesWise(category_id, sub,orderAscDesc, topRated) async {
  var headers = {
    'Cookie':
    'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_products'));
  request.fields
      .addAll({'user_id': App.localStorage.getString("userId").toString(),'category_id': category_id,
    'subcategory_id': sub,
    'sort': 'pv.price',
    'order' : orderAscDesc,
    'top_rated_product' : topRated
  });
  print("@@ $sub && $orderAscDesc && $topRated && $category_id");

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return SubCategoryModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<SubCategoryModel?> productSubCategoriesCategoriesWiseSort(category_id, sub, orderAscDesc) async {
  var headers = {
    'Cookie':
    'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_products'));
  request.fields
      .addAll({'category_id': category_id,
    'subcategory_id': sub,
    'sort': 'pv.price',
    'order' : orderAscDesc,
  });

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return SubCategoryModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

//https://alphawizztest.tk/Atticadigitamarketing/app/v1/api/get_product_by_id

Future<SubCategoriGoldorsilver?> productSubCategoriesCategoriesWiseList(id) async {
  var headers = {
    'Cookie':
    'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_subcategories'));
  request.fields
      .addAll({'id': id,'product_type_status' : "2"});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return SubCategoriGoldorsilver.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<SubCategoriGoldorsilver?> productSubCategoriesCategoriesWiseListJewellery(id) async {
  var headers = {
    'Cookie':
    'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_subcategories'));
  request.fields
      .addAll({'id': id, 'product_type_status' : "1"});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return SubCategoriGoldorsilver.fromJson(json.decode(str));
  } else {
    return null;
  }
}
Future<ProductDetailsByIdModel?> getProductyid(id) async {
  var headers = {
    'Cookie':
    'ci_session=me3pm54rt85a7q3gl2an6odso1pr3ci5; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_products'));
  request.fields
      .addAll({'id': id, "user_id": App.localStorage.getString("userId").toString(),});

  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return ProductDetailsByIdModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetGoldCoinModel?> goldCoin(category_id) async {
  var headers = {
    'Cookie':
        'ci_session=b3ohruen23f9ttjeekldaee4lm2u5qc4; ekart_security_cookie=8eaf16bd90e896dc92628c1bcd875530'
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse(baseUrl1 + 'get_productdlisting'));
  request.fields.addAll({'category_id': '$category_id'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetGoldCoinModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddToCardModel?> addtocard(userid, qty, productid) async {
  var headers = {'Cookie': 'ci_session=eug6v2np9dp2fa13onevi9eqmlfdlg3a'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'add_to_cart'));
  request.fields.addAll(
      {'user_id': '$userid', 'qty': '$qty', 'product_id': '$productid'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return AddToCardModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCartModel?> getCartdata(userid) async {
  var headers = {'Cookie': 'ci_session=2kcgb2bdv86mqm266sc5o3ab60ql616l'};
  var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_cart'));
  request.fields.addAll({'user_id': '$userid'});
  print(request);
  print(request.fields);
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetCartModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetWishListModel?> getwishlist(userid) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_favorites'));
  request.fields
      .addAll({'user_id': App.localStorage.getString("userId").toString()});

  print(request);
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetWishListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCouponModel?> getCouponcode() async {
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'get_promo_codes'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetCouponModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<TransationModeOnlyAmount?> getTransationCash(String? userId) async {
  TransationModeOnlyAmount transationMode = TransationModeOnlyAmount();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'transactions'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    'transaction_type':"wallet",
    'type':"debit",
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransationModeOnlyAmount.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<WithdrawHistory?> getTransationHistory(String? userId) async {
  WithdrawHistory transationMode = WithdrawHistory();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl + 'get_withdrawl_request'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    // 'transaction_type':"wallet",
    // 'type':"debit",
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return WithdrawHistory.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<TransationModeOnlyAmount?> addAmount(String amount) async {
   const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  TransationModeOnlyAmount transationMode = TransationModeOnlyAmount();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl + 'add_wallet'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    'amount':"$amount",
    'transaction_id':getRandomString(5),
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransationModeOnlyAmount(message: "Payment Added Success");
  } else {
    return TransationModeOnlyAmount(message: "Error Payment");
  }
}

Future<TransactionModel?> getTransation(id) async {
  TransactionModel transationMode = TransactionModel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'all_transcation'));
  request.fields.addAll({
    'user_id': id,
  });

  request.headers.addAll(headers);
  print(request);
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransactionModel.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<TransactionModel?> emailVerication(email) async {
  TransactionModel transationMode = TransactionModel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl + 'all_transcation'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    'email': email,
  });

  request.headers.addAll(headers);
  print(request);
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransactionModel(message: "Email sent your email id");
  } else {
    return transationMode;
  }
}

Future<Withdrawmodel?> withDrawApi({required String amount,
  String? upiId,  String? BankName,  String? accountNumber,  String? ifscCode,
  String? accountHoldername}) async {
  Withdrawmodel transationMode = Withdrawmodel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
  http.MultipartRequest('POST', Uri.parse(baseUrl + 'withdrawl_requests'));
  request.fields.addAll({
    'user_id': App.localStorage.getString("userId").toString(),
    'amount': amount,
  "upi_id":upiId!,
  "bank_name": BankName!,
  "account_number": accountNumber!,
  "ifsc_code": ifscCode!,
  "account_holder_name": accountHoldername!
  });
    print("checking paramters here ${request.fields} and ${baseUrl}withdrawl_requests");
  request.headers.addAll(headers);
  print(request);
  print(request.fields);
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return Withdrawmodel.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<TransactionModel?> getTransationType(id, type) async {
  TransactionModel transationMode = TransactionModel();
  var headers = {'Cookie': 'ci_session=jktap2bh3u0d3j6pebpds5oir9eokfgm'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl + 'all_transcation'));
  request.fields.addAll({'user_id': id, "type": type});

  print("this is transaction data ${request.fields.toString()}  and ${baseUrl}all_transcation");
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return TransactionModel.fromJson(json.decode(str));
  } else {
    return transationMode;
  }
}

Future<EditProfileModel?> editprofle(String name, String mobile) async {
  var headers = {
    'Cookie':
        'ci_session=8phq7qv7e51gq7jh41q3ea8n4ei0c75m; ekart_security_cookie=75e4d3b861f7e0403f42abd768a206e0'
  };
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'update_profile'));
  request.fields.addAll({
    'id': App.localStorage.getString("userId").toString(),
    'username': 'Shubham Shinde',
    'mobile': '7485968574',
    'image': 'Screenshot_from_2022-03-29_19-10-51.png'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return EditProfileModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<NumberModel?> changeNumber(String mobile) async {
  var headers = {'Cookie': 'ci_session=ptfjdlp3dfa4u1a8q25ojul1nqh48e0o'};
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'change_number'));
  request.fields.addAll({
    'id': App.localStorage.getString("userId").toString(),
    'Mobile': '1234567892'
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return NumberModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<PruchaseModel?> purchaseGold(
    userId, buyAmount, gramValue, isGold, context) async {
  String goldurl = baseUrl1 + "pruchase_gold";
  String silveryrl = baseUrl1 + "purchase_sliver";
  var request =
      http.MultipartRequest('POST', Uri.parse(isGold ? goldurl : silveryrl));

  request.fields.addAll({
    'user_id': userId,
    'razorpay_payment_id': razorPayKey,
    'buy_amount': buyAmount,
    'gold': '$gramValue'
  });

  print("this is buy gold request ======>>>>  ${request.fields.toString()}");
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return PruchaseModel.fromJson(json.decode(str));
  } else {
    return PruchaseModel(message: "Something went wrong");
  }
}

Future<UserDetailsModel> userDetails(userId) async {
  UserDetailsModel userDetailsModel = UserDetailsModel();
  var request =
      http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'user_datails'));
  request.fields
      .addAll({'user_id': App.localStorage.getString("userId").toString()});

  http.StreamedResponse response = await request.send();
  print(request);
  print(request.fields);

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return UserDetailsModel.fromJson(json.decode(str));
  } else {
    return userDetailsModel;
  }
}

Future<SellSilverGoldModel> sellGoldOrSilver(
    userId, grams, total, isGold, context) async {
  var headers = {'Cookie': 'ci_session=369m0tojim7hjgo5dt6dlc7skt0cl5kf'};
  SellSilverGoldModel sellSilverGoldModel = SellSilverGoldModel();
  String goldSellUrl = "sell_gold";
  String silverSellUrl = "sell_silver";
  var request = http.MultipartRequest('POST',
      Uri.parse(isGold ? baseUrl + goldSellUrl : baseUrl + silverSellUrl));
  request.fields
      .addAll({'user_id': '$userId', 'sell': '$grams', 'total': '$total'});
  print("this is request @@ ${request.fields.toString()}");

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print("^^ ${str.toString()}");
    if(str == "null"){
      return SellSilverGoldModel(message: "Limit Extend");
    }else{
      return SellSilverGoldModel.fromJson(json.decode(str));
    }
  } else {
    return sellSilverGoldModel;
  }
}


Future<GetNotificationModel?> getNotification() async{
  var headers = {
    'Cookie': 'ci_session=5gueac7g05v5t12tbt7nluvihoai58q3'
  };
  var request = http.Request('POST',
      Uri.parse(baseUrl1 + 'get_notifications'));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    print(str);
    return GetNotificationModel.fromJson(json.decode(str));
  } else {
    return null;
  }

}