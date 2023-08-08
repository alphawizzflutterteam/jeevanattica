import 'package:atticadesign/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Utils/Common.dart';
import '../bottom_navigation.dart';

class PinScreenverify extends StatefulWidget {
  String pin;
   PinScreenverify({required this.pin, Key? key}) : super(key: key);

  @override
  State<PinScreenverify> createState() => _PinScreenverifyState();
}

class _PinScreenverifyState extends State<PinScreenverify> {
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // @override
  // void initState() async{
  //   // TODO: implement initState
  //   super.initState();
  //   var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'verify_mpin'));
  //   request.fields.addAll({'user_id': '${App.localStorage.getString("userId").toString()}','mpin': '${pass.text}'});
  //   print(request);
  //   print(request.fields.toString() + "ssss");
  //   http.StreamedResponse response = await request.send();
  //   print(response.stream.toString());
  //   if (response.statusCode == 200) {
  //     if(pass.text == widget.pin) {
  //       // Navigator.pushAndRemoveUntil(context,
  //       //     MaterialPageRoute(builder: (context) => BottomBar()), (
  //       //         route) => false);
  //     } else{
  //       Fluttertoast.showToast(msg: "Wrong pin");
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: "Wrong pin");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     // backgroundColor: Color(0xff0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xFF15654F),
        title: Text("M-Pin Verification"),
      ),
      bottomNavigationBar:   GestureDetector(
        onTap: () async {
          var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'verify_mpin'));
          request.fields.addAll({'user_id': '${App.localStorage.getString("userId").toString()}','mpin': '${pass.text}'});
          print(request);
          print(request.fields.toString() + "ssss");
          http.StreamedResponse response = await request.send();
          print(response.stream.toString());
          if (response.statusCode == 200) {
            if(pass.text == widget.pin) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => BottomBar()), (
                      route) => false);
            }
            else{
              Fluttertoast.showToast(msg: "Wrong pin");
            }
          }
          else {
            Fluttertoast.showToast(msg: "Wrong pin");
          }
        },
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffF1D459), Color(0xffB27E29)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30.0)),
          height: 50,
          width: 160,
          child: Center(
            child: Text(
              "Confirm Pin",
              style: TextStyle(color: colors.white1, fontSize: 15),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.0),
                      child:  Text("Enter Mpin",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    Container(
                      width: 200,
                      height: 60,
                      child: TextFormField(
                        onChanged: (value){
                          if(widget.pin == value){
                            if(value.length == 4){
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) => BottomBar()), (
                                      route) => false);
                            }
                            else{
                              Fluttertoast.showToast(msg: "Wrong pin");
                            }
                          }
                          // else{
                          //   Fluttertoast.showToast(msg: "Wrong pin");
                          // }
                        },
                        validator: ( value) {
                          if (value!.isEmpty) {
                            return 'Please enter M-pin';
                          }
                          return null;},
                        controller: pass,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          counterText: "",
                          labelText: 'M-pin',
                        ),

                      ),
                    ),
                  // widget.pin == pass.text.toString() ?
                  //      SizedBox(height: 0,)
                  //     :   Text("Wrong pin",
                  //   style: TextStyle(
                  //     color: MyColorName.primaryDark,
                  //   ),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
