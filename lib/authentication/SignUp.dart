import 'dart:async';

import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Helper/Session.dart';
import 'package:atticadesign/Model/registrtion_model.dart';
import 'package:atticadesign/Utils/ApiBaseHelper.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/Session.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/authentication/otp.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:atticadesign/privacypolicy.dart';
import 'package:atticadesign/termsandcondition.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../Helper/Color.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  //
  const SignUp({Key? key}) : super(key: key);

  // String date = "";
  // DateTime selectedDate = DateTime.now();

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController dateinput = TextEditingController();
  bool isChecked = false;
  String choice = '';
  final nameC = TextEditingController();
  final mobileC = TextEditingController();
  // final ageC = TextEditingController();
  // final genderC = TextEditingController();

  List categories = ["Male", "Female", "Other"];
  List selectedCategories = [];

  String date = "";
  DateTime selectedDate = DateTime.now();

  // get dateinput => null;

  // List<Gender> genders = new List<Gender>();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   genders.add(new Gender("Male", MdiIcons.genderMale, false));
  //   genders.add(new Gender("Female", MdiIcons.genderFemale, false));
  //   genders.add(new Gender("Others", MdiIcons.genderTransgender, false));
  // }

  @override
  Widget build(BuildContext context) {
    var selectedDate;
    var grad1Color;
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(100.w, 8.h),
          child: AppBar(
            backgroundColor: colors.primaryNew,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: colors.secondary2,
              ),
            ),
            // flexibleSpace: Image.asset(
            //   'assets/signup/signuptop.png',
            //   fit: BoxFit.fill,
            // ),
            title: Text(
              'Sign Up',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: colors.primary,
            // image: DecorationImage(
            //     image: AssetImage("assets/otppage/back.png"),
            //     fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Your Name',
                  style: TextStyle(
                    color: colors.fontClr,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: colors.blackTemp.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: TextField(
                      controller: nameC,
                      // obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          // border: OutlineInputBorder(),
                          // labelText: 'enter Your name here',
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter Your Name',
                          hintStyle: TextStyle(
                            color:colors.blackTemp.withOpacity(0.6),
                          )
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Your Mobile Number',
                  style: TextStyle(
                    color: colors.fontClr,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: colors.blackTemp.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Center(
                    child: TextField(
                      controller: mobileC,
                      maxLength: 10,
                      // obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          // border: OutlineInputBorder(),
                          // labelText: 'enter Your name here',
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter Your Mobile Number',
                          hintStyle: TextStyle(
                            color:colors.blackTemp.withOpacity(0.6),
                          )),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Your Gender',
                  style: TextStyle(
                    color: colors.fontClr,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(25),
                                    right: Radius.circular(25))),
                            side:
                                BorderSide(width: 1, color: Color(0xff0C3B2E)),
                            backgroundColor: colors.primary,
                            label: Text('Male',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colors.black54.withOpacity(0.8),
                                    fontSize: 20)),
                            labelPadding: EdgeInsets.symmetric(horizontal: 10),
                            selected: choice == 'Male',
                            onSelected: (bool selected) {
                              setState(() {
                                print("left::");
                                choice = "Male";
                              });
                            },
                            selectedColor: colors.secondary2,
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(25),
                                    right: Radius.circular(25))),
                            // ShapeBorder avatarBorder = const CircleBorder(),
                            //   avatarBorder:const CircleBorder(),
                            side:
                                BorderSide(width: 1, color: Color(0xff0C3B2E)),
                            backgroundColor: colors.primary,
                            label: Text('Female',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colors.black54.withOpacity(0.7),
                                    fontSize: 20)),
                            labelPadding: EdgeInsets.symmetric(horizontal: 10),
                            // selected: choice== 'right',
                            selected: choice == 'Female',
                            onSelected: (bool selected) {
                              setState(() {
                                print("right::");
                                choice = "Female";
                              });
                            },
                            selectedColor: colors.secondary2,
                          ),
                          ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(25),
                                    right: Radius.circular(25))),
                            side:
                                BorderSide(width: 1, color: Color(0xff0C3B2E)),
                            backgroundColor: colors.primary,
                            label: Text('Other',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: colors.black54.withOpacity(0.7),
                                    fontSize: 20)),
                            labelPadding: EdgeInsets.symmetric(horizontal: 10),
                            selected: choice == 'Other',
                            onSelected: (bool selected) {
                              setState(() {
                                print("left::");
                                setState(() {
                                  print("left::");
                                  choice = "Other";
                                });
                              });
                            },
                            selectedColor: colors.secondary2,
                          ),
                        ]),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Your Age',
                  style: TextStyle(
                    color: colors.fontClr,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: colors.blackTemp.withOpacity(0.1)),
                child: TextFormField(
                  controller: dateinput,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  //editing controller of this TextField
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    hintStyle:
                        TextStyle(
                          color : colors.blackTemp.withOpacity(0.6),),
                    contentPadding: EdgeInsets.only(left: 20),
                    hintText: "Enter Your Age",

                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              /*Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.all(Colors.grey),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  // Text(
                  //   'By signing up you agree to our Terms of Use',
                  //   style: TextStyle(
                  //     color: Colors.white.withOpacity(1),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'By signing up you agree to our',
                              style: TextStyle(
                                  color: Color(0xffffffff))),
                          TextSpan(
                              text: ' Terms of Use ',
                              style: TextStyle(color: Color(0xffF95873))),
                          TextSpan(
                              text: 'and',
                              style: TextStyle(
                                  color: Color(0xffffffff))),
                          TextSpan(
                              text: ' \nPrivacy Policy.',
                              style: TextStyle(color: Color(0xffF95873)))
                        ],
                      ),
                    ),
                  )
                ],
              ),*/
              ListTile(
                horizontalTitleGap: 0.0,
                leading: Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(Colors.grey),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),

                title: Wrap(
                  children: [
                    Text("By Signing up you agree to our ",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditions()));
                    },
                      child: Text("Terms of Use",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Text("  and",
                      style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),),
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
                      },
                      child: Text("Privacy Policy",

                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 300,
                child: InkWell(
                  onTap: () async {
                    Pattern pattern = r'\b([0-9]|[1-9][0-9])\b';
                    RegExp regex = new RegExp(pattern.toString());

                    if(nameC.text==""){
                      setSnackbar("Please Enter Name", context);
                      return ;
                    }
                    if(mobileC.text==""||mobileC.text.length!=10){
                      setSnackbar("Please Enter Valid Mobile Number", context);
                      return ;
                    }
                    if(choice==""){
                      setSnackbar("Please Select Gender", context);
                      return ;
                    }
                    if(dateinput.text=="" && !regex.hasMatch(dateinput.text)){
                      setSnackbar("Please Enter Age", context);
                      return ;
                    }
                    if(!isChecked){
                      setSnackbar("Please Accept Terms", context);
                      return ;
                    }
                    setState(() {
                      loading =true;
                    });
                    loginUser();
                   /* if (nameC.text.isNotEmpty && mobileC.text.isNotEmpty
                        // ageC.text.isNotEmpty &&
                        // genderC.text.isNotEmpty
                        ) {
                      var name = nameC.text.toString();
                      var mobile = mobileC.text.toString();
                      // var gender = genderC.text.toString();
                      // var age = ageC.text.toString();
                      RegistrtionModel? regis =
                          await registration(name, mobile, "male", 12);
                      if (regis!.error == false) {
                        // Common().toast("User Register Successfully");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomBar()),
                        );
                      } else {
                        // Common().toast("${regis.message.toString()}");
                      }
                    } else {
                      // Common().toast("Fill All Fields");
                    }*/
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                             colors.secondary2,
                              Color(0xffB27E29),
                            ])),
                    child: Center(
                      child: !loading?Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff0F261E).withOpacity(1),
                        ),
                      ):Center(child: CircularProgressIndicator(color: Colors.white,),),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    InkWell(
                      child: Text(
                        ' Log in Now',
                        style: TextStyle(
                            fontSize: 15,
                            color:colors.secondary2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
          "name": nameC.text.trim().toString(),
          "gender": choice.toString(),
          "age": dateinput.text.trim().toString(),
          "fcm_id": fcmToken.toString(),
          "email": "alpdha@gmail.com",
          "password": "12345678",
        };
        Map response =
            await apiBase.postAPICall(Uri.parse(baseUrl + "register"), data);
        print(response);
        bool status = true;
        String msg = response['message'];
        setState(() {
          loading = false;
        });
        setSnackbar(msg, context);
        if (!response['error']) {
          //navigateScreen(context, RegisterPage(_numberController.text.trim()));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpPage(
                      otp: response['otp'].toString(),
                      data: mobileC.text.toString(),
                    name: nameC.text.trim().toString(),
                    age: dateinput.text.trim().toString(),
                    choose: choice.toString(),
                  )
              )
          );
          // navigateScreen(context, VerificationPage(_numberController.text.trim()));
        } else {}
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
