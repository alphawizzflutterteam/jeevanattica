import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/login_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/material.dart';

import '../Helper/Color.dart';
import '../bottom_navigation.dart';
import 'SignUp.dart';
import 'otp.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);



  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  final mobileC = TextEditingController();
  bool isLoggedIn = false;

  String? firebaseGmail,firebaseUser;
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    final result =  await FirebaseAuth.instance.signInWithCredential(credential);
    firebaseGmail = result.user!.email;
    firebaseUser = result.user!.displayName;
    print("firebase data here ${result.user!.email} and ${result.user!.displayName}");
      if(result != null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
      }
  }


  void onLoginStatusChanged(bool isLoggedIn) {

    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/loginpage/Loginbacgnd.png"),
                      fit: BoxFit.cover),
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0,left: 30),
                        child: Image.asset(
                          'assets/loginpage/attica.png',
                          width: 230,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/loginpage/Path.png',
                        width: 250,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: colors.blackTemp,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0)),
                              color: colors.blackTemp.withOpacity(0.2),
                            ),
                            child: Center(
                                child: Text(
                              "+91",
                              style: TextStyle(
                                color: colors.black54
                                //Colors.amber,
                              ),
                            )),
                          ),
                          Container(
                            height: 50,
                            width: 270,
                            padding: EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0)),
                              color: colors.blackTemp.withOpacity(0.1),
                            ),
                            child: Container(
                              child: Center(
                                child: TextFormField(
                                  maxLength: 10,
                                  controller: mobileC,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintText: "Enter mobile number",
                                      hintStyle: TextStyle(
                                          color: colors.blackTemp.withOpacity(0.3)
                                      ),

                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 325,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffF1D459), Color(0xffB27E29)]),
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if(mobileC.text==""||mobileC.text.length!=10){
                              setSnackbar("Please Enter Valid Mobile Number", context);
                              return ;
                            }
                            setState(() {
                              loading =true;
                            });
                            loginUser();
                           /* if (mobileC.text.isNotEmpty && mobileC.text.toString().length>=10) {
                              var mobile = mobileC.text.toString();
                              LoginModel? log = await login(mobile);
                              if (log!.error == false) {
                                Common().toast("${log.otp.toString()}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          OtpPage(otp: log.otp.toString())),
                                );
                              } else {
                                Common().toast("${log.message.toString()}");
                              }
                            } else if(mobileC.text.isNotEmpty && mobileC.text.toString().length<9 ) {
                              Common().toast("Please Enter Valid Mobile Number");
                            }else {
                              Common().toast("Please Enter Your Mobile Number");
                            }*/
                          },
                          child: !loading?Center(
                            child: Text(
                              'GET OTP',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0F261E).withOpacity(1),
                              ),
                            ),
                          ):Center(child: CircularProgressIndicator(color: colors.blackTemp,)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Image.asset('assets/loginpage/Path.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                              color: colors.blackTemp,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Image.asset('assets/loginpage/Path.png'),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         /* Container(
                            child: InkWell(
                                //         onTap: (){
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(builder: (context) => MyCart()),
                                // );
                                // },
                                child: Image.asset(
                              'assets/loginpage/facebook.png',
                              height: 50,
                              width: 50,
                            )),
                          ),*/
                          InkWell(
                            onTap: () {
                              signInWithGoogle();
                            },
                            child: Container(
                              child: Image.asset(
                                'assets/loginpage/google.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUp()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't You have an account?",
                              style:
                                  TextStyle(color: colors.blackTemp, fontSize: 15),
                            ),
                            Text(
                              ' Sign Up Now',
                              style: TextStyle(
                                color: Color(0xffFBBC05),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  bool loading = false;
  loginUser() async {
    await App.init();
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        Map data;
        data = {
          "mobile": mobileC.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
        };
        Map response =
        await apiBase.postAPICall(Uri.parse(baseUrl + "login_with_otp"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if(!response['error']){
          //navigateScreen(context, RegisterPage(_numberController.text.trim()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpPage(otp:response['data']['otp'].toString(),data:mobileC.text.trim().toString())));
          // navigateScreen(context, VerificationPage(_numberController.text.trim()));
        }else{

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          loading = false;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        loading = false;
      });
    }
  }

}


// void initiateFacebookLogin() async {
//   var facebookLogin = FacebookLogin();
//   var facebookLoginResult =
//   await facebookLogin.logInWithReadPermissions(['email']);
//   switch (facebookLoginResult.status) {
//     case FacebookLoginStatus.error:
//       print("Error");
//       // onLoginStatusChanged(false);
//       break;
//     case FacebookLoginStatus.cancelledByUser:
//       print("CancelledByUser");
//      //  onLoginStatusChanged(false);
//       break;
//     case FacebookLoginStatus.loggedIn:
//       print("LoggedIn");
//       // onLoginStatusChanged(true);
//       break;
//   }
// }
