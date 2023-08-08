import 'dart:async';
import 'package:atticadesign/Utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';



setPrefrenceBool(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}



back() {
  return BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Colors.white],
        stops: [0, 1]),
  );
}

shadow() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(color: Color(0x1a0400ff), offset: Offset(0, 0), blurRadius: 30)
    ],
  );
}

placeHolder(double height) {
  return AssetImage(
    'assets/images/placeholder.png',
  );
}

erroWidget(double size) {
  return Image.asset(
    'assets/images/placeholder.png',
    height: size,
    width: size,
  );
}

errorWidget(double size) {
  return Icon(
    Icons.account_circle,
    color: Colors.grey,
    size: size,
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

getAppBar(
  String title,
  BuildContext context,
) {
  return AppBar(
    titleSpacing: 0,

    leading: Builder(
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: Icon(
                Icons.arrow_back_ios_rounded,

              ),
            ),
          ),
        );
      },
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
    ),
    actions: <Widget>[


    ],
  );
}

getSimpleAppBar(
  String title,
  BuildContext context,
) {
  return AppBar(
    titleSpacing: 0,

    leading: Builder(builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () => Navigator.of(context).pop(),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,

            ),
          ),
        ),
      );
    }),
    title: Text(
      title,

    ),
  );
}



setSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content:text(
      msg,
      isCentered: true,
      textColor: Colors.white,
    ),
    behavior: SnackBarBehavior.floating,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.black,
    elevation: 1.0,
  ));
}

String imagePath = 'assets/images/';

noIntText(BuildContext context) {
  return Container(
      child: Text(getTranslated(context, 'NO_INTERNET')!,
          style: Theme.of(context)
              .textTheme
              .headline5!
             ));
}

noIntDec(BuildContext context) {
  return Container(
    padding: EdgeInsetsDirectional.only(top: 30.0, start: 30.0, end: 30.0),
    child: Text(getTranslated(context, 'NO_INTERNET_DISC')!,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(

              fontWeight: FontWeight.normal,
            )),
  );
}

Widget showCircularProgress(bool _isProgress, Color color) {
  if (_isProgress) {
    return Center(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color),
    ));
  }
  return Container(
    height: 0.0,
    width: 0.0,
  );
}

imagePlaceHolder(double size, BuildContext context) {
  return new Container(
    height: size,
    width: size,
    child: Icon(
      Icons.account_circle,

      size: size,
    ),
  );
}

String? validateUserName(String value, String? msg1, String? msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length <= 1) {
    return msg2;
  }
  return null;
}

String? validateMob(String value, String? msg1, String? msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length < 6) {
    return msg2;
  }
  return null;
}

String? validateCountryCode(String value, String msg1, String msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length <= 0) {
    return msg2;
  }
  return null;
}

String? validatePass(String value, String? msg1, String? msg2) {
  if (value.length == 0)
    return msg1;
  else if (value.length <= 5)
    return msg2;
  else
    return null;
}

String? validateAltMob(String value, String? msg) {
  if (value.isNotEmpty) if (value.length < 9) {
    return msg;
  }
  return null;
}

String? validateField(String value, String? msg) {
  if (value.length == 0)
    return msg;
  else
    return null;
}

String? validatePincode(String value, String? msg1) {
  if (value.length == 0)
    return msg1;
  else
    return null;
}

String? validateEmail(String value, String? msg1, String? msg2) {
  if (value.length == 0) {
    return msg1;
  } else if (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
          r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
          r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(value)) {
    return msg2;
  } else {
    return null;
  }
}

Widget getProgress() {
  return Center(child: CircularProgressIndicator());
}

Widget getNoItem(BuildContext context) {
  return Center(child: Text(getTranslated(context, 'noItem')!));
}

Widget shimmer(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),

  );
}

Widget singleItemSimmer(BuildContext context) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  );
}

simmerSingleProduct(BuildContext context) {
  return Container(
      //width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
  );
}
Locale _locale(String languageCode) {
  switch (languageCode) {
    case "en":
      return Locale("en", 'US');
    case "zh":
      return Locale("zh", "CN");
    case "es":
      return Locale("es", "ES");
    case "hi":
      return Locale("hi", "IN");
    case "ar":
      return Locale("ar", "DZ");
    case "ru":
      return Locale("ru", "RU");
    case "ja":
      return Locale("ja", "JP");
    case "de":
      return Locale("de", "DE");
    default:
      return Locale("en", 'US');
  }
}

String? getTranslated(BuildContext context, String key) {

}



Map<String, String> get headers => {

    };

dialogAnimate(BuildContext context, Widget dialge) {
  return showGeneralDialog(

      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // pageBuilder: null
      pageBuilder: (context, animation1, animation2) {
        return Container();
      } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
      );
}

String getString(String name){
  String temp ="";
  if(name!=null&&name!=""){
    temp = name[0].toString().toUpperCase()  + name.toString().substring(1).toLowerCase();
  }else{
    temp ="No Data";
  }
  return temp;
}
String parseString(name){
  String temp ="";
  if(name!=null&&name!=""){
    temp = parse(name).body!.text.toString();
  }else{
    temp ="No Data";
  }
  return temp;
}
String getDate(date){
  String temp ="";
  if(date!=null&&date!=""){
    temp = DateFormat.yMMMMEEEEd().format(DateTime.parse(date.toString()));
  }else{
    temp ="Not Data";
  }
  return temp;
}