/*fonts*/
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';


const fontRegular = 'Regular';
const fontMedium = 'Medium';
const fontSemibold = 'Semibold';
const fontBold = 'Bold';
/* font sizes*/
const textSizeSmall = 12.0;
const textSizeSMedium = 14.0;
const textSizeMedium = 16.0;
const textSizeLargeMedium = 18.0;
const textSizeNormal = 20.0;
const textSizeLarge = 24.0;
const textSizeXLarge = 34.0;

/* margin */

const spacing_control_half = 2.0;
const spacing_control = 4.0;
const spacing_standard = 8.0;
const spacing_middle = 10.0;
const spacing_standard_new = 16.0;
const spacing_large = 24.0;
const spacing_xlarge = 32.0;
const spacing_xxLarge = 40.0;


final int timeOut = 60;
const int perPage = 10;

final String appName = 'Sanghavi Digi Gold';
bool notificationStatus = true;
int notificationId = 1;
final String packageName = 'com.sanghavi.user';
const String languageCode = 'languageCode';
final String baseUrl =
    "https://developmentalphawizz.com/jeevan/app/v1/api/";
    // 'https://alphawizztest.tk/Atticadigitamarketing/app/v1/api/';
final String playUrl = "https://play.google.com/store/apps/details?id=$packageName";
final String livePrice = "${baseUrl}get_rates";
String? curTikId = '';
String? fcmToken;
String? term = "";
String? privacy = '';
String? returned = "";
String? delivery = "";
String? company = "";
String address="";
String homeAddress="";
double latitude=0;
double longitude = 0;
String proImage="";
int likeCount = 0;
String addressId="";
String bookingId ="";
String deliveryLocation = "", name = "", email = "", mobile = "", image = "";
String bankName = "",accountNumber = "",code="",cheque = "",insurance = "";
String drivingImage = "",brand = "",model2 = "", number = "",refer ="",panCard ="",adharCard = "",vehicle = "";
bool doLock = false;
String rating = "0";
bool notification = true;
String gender1 = "",dob = "";
String profileStatus = "";
String razorPayKey="rzp_test_CpvP0qcfS4CSJD";
String razorPaySecret="rzp_test_CzVEZjetT2HvfwMDkMfaO6Oq1JD1BpiWuQseSX";
// final String baseUrl1 = 'https://alphawizztest.tk/TAXI_APP/api/';
double getHeight(double height){
  double tempHeight = 0.0;
  tempHeight = ((height * 100)/812).h;
  return tempHeight;
}
double getWidth(double width){
  double tempWidth = 0.0;
  tempWidth = ((width * 100)/375).w;
  return tempWidth;
}
double getHeight1(double height){
  double tempHeight = 0.0;
  tempHeight = ((height * 100)/1280).h;
  return tempHeight;
}
double getWidth1(double width){
  double tempWidth = 0.0;
  tempWidth = ((width * 100)/720).w;
  return tempWidth;
}
Widget boxWidth(double width){
  return SizedBox(width: getWidth(width),);
}

Widget boxHeight(double height){
  return SizedBox(height: getHeight(height),);
}
navigateScreen(BuildContext context,Widget widget){
  Navigator.push(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
navigateBackScreen(BuildContext context,Widget widget){
  Navigator.pushReplacement(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.rightToLeft,
        duration: Duration(milliseconds: 500),
      ));
}
back(BuildContext context){
  Navigator.pop(context);
}
const String PLACED = 'confirmed';
const String SHIPED = 'arrived';
const String PROCESSED = 'picked up';
const String DELIVERD = 'delivered';
const String WAITING = 'awaiting';
const String CANCLED = 'cancelled';
const String RETURNED = 'returned';