import 'dart:async';
import 'dart:convert';

import 'package:atticadesign/Helper/introoooo.dart';
import 'package:atticadesign/Provider/live_price_provider.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/PushNotificationService.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/screen/verify-mpin-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'Helper/Session.dart';
import 'Helper/intro.dart';
import 'Model/banner_model.dart';
import 'Model/liveprice_model.dart';
import 'Utils/ApiBaseHelper.dart';
import 'intro_slider.dart';
import 'package:http/http.dart' as  http;
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
class MySplshScreen extends StatefulWidget {
  @override
  _MySplshScreen createState() => _MySplshScreen();
}

class _MySplshScreen extends State<MySplshScreen> {

  Future<BannerModel?> getBaneerHomeScreen() async {
    var headers = {
      'Cookie':
      'ci_session=2i228lq631ebvjeli9s2e28mvhjhsb5r; ekart_security_cookie=7ed2dd51fda10d7c683041e2e6fbf938'
    };
    var request = http.Request('GET', Uri.parse(baseUrl + 'get_slider_images'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return BannerModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }


  ApiBaseHelper apiBase = new ApiBaseHelper();
  getLivePrice() async {
    try {
      // setState(() {
      //   cartList.clear();
      // });
      Map params = {
        // "get_user_cart": "1",
        // "user_id": App.localStorage.getString("userId").toString(),
      };
      Map response = await apiBase.postAPICall(
          Uri.parse(livePrice), params);
      if (response.isNotEmpty) {
        context.read<LivePriceProvider>().setGold916(response['data']['916_gold_charge'].toString());
        context.read<LivePriceProvider>().setGold999(response['data']['999_gold_charge'].toString());
        // cartList.clear();
        // for (var v in response['cart_data']) {
        //   setState(() {
        //     cartList.add(CartData.fromJson(v));
        //   });
        // }
        // totalCount = cartList.length;
        print("gold-916 is@@ ${response['data']['916_gold_charge'].toString()}");
        print("gold-999 is** ${response['data']['999_gold_charge'].toString()}");
      }
    } on TimeoutException catch (_) {
      setSnackbar("Something Went Wrong", context);
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    getBaneerHomeScreen();
    getLivePrice();
    final pushNotificationService = PushNotificationService(
        context: context);
    pushNotificationService.initialise();
    Timer(
        Duration(seconds: 3),
            () {
          changePage(context);
        } );

  }
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint  to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  ApiBaseHelper a = ApiBaseHelper();

  changePage(BuildContext context)async{

    await App.init();
    print(App.localStorage.getString("userId"));
    if(App.localStorage.getString("userId")!=null){
      String? pin = "";

    if(App.localStorage.containsKey("pin")){
         pin = App.localStorage.getString("pin");
      }
    print("@@@ $pin");
      Map params = {
        "mpin": " ${pin}",
        "user_id": App.localStorage.getString("userId"),
      };
      Map response = await a.postAPICall(
          Uri.parse(baseUrl + "verify_mpin"), params);
      if (!response['error']) {

     /* if(_supportState == _SupportState.supported){
        bool authenticated = false;
        try {
          setState(() {
            _isAuthenticating = true;
            _authorized = 'Authenticating';
          });
          authenticated = await auth.authenticate(
            localizedReason:
            'Scan your fingerprint  to authenticate',
            options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: true,
              useErrorDialogs: true,
              sensitiveTransaction: true,
            ),
          );
          setState(() {
            _isAuthenticating = false;
            _authorized = 'Authenticating';
          });
        } on PlatformException catch (e) {
          print(e);
          setState((){
            _isAuthenticating = false;
            _authorized = 'Error - ${e.message}';
          });
          return;
        }
        if (!mounted) {
          return;
        }

        final String message = authenticated ? 'Authorized' : 'Not Authorized';
        setState(() {
          _authorized = message;
        });
        if(authenticated != null && authenticated){
          curUserId = App.localStorage.getString("userId").toString();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
        }
      }
      else{
        curUserId = App.localStorage.getString("userId").toString();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
      }*/
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> PinScreenverify(pin: pin.toString())), (route) => false);
   }
      else if(response['error']){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> PinScreenverify(pin: pin.toString())), (route) => false);
       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
      }
      else{
        Fluttertoast.showToast(msg:"Invalid Pin" );
      }
      }else{
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
          builder: (context) => Introslider(),
    ));
    }
  }
  @override
  Widget build(BuildContext context) {
     return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.grey[900],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.dstATop),
          image: const AssetImage('assets/splash/bacgnd.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/splash/attica.png',
            width: 280,
          ),
        ],
      ),
    );
  }
}