import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;

import '../Api/api.dart';
import '../Utils/Common.dart';
import 'Color.dart';
class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool changeMpin = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(App.localStorage.containsKey("pin")){
     var pin = App.localStorage.getString("pin");
     if(pin == ""){
       changeMpin = false;
     }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     // backgroundColor: Color(0xff0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xFF15654F),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.secondary2,
          ),
        ),
        title: Text("M-Pin Verification"),
        actions: [

        ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        validator: ( value) {
                          if (value!.isEmpty) {
                            return 'Please enter Mpin';
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
                          labelText: 'Mpin',
                        ),

                      ),
                    ),

                    SizedBox(height: 20,),
                    const Padding(
                      padding:  EdgeInsets.symmetric(vertical: 10.0),
                      child:  Text("Re-Enter Mpin",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    Container(
                      width: 200,
                      height: 60,
                      child: TextFormField(
                        controller: confirmPass,
                        //obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 4,

                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          counterText: "",
                          labelText: 'Re-enter Mpin / New Pin ',
                        ),
                        // style: const TextStyle(
                        //   letterSpacing: 3
                        // ),
                        validator: ( value) {
                          if (value!.isEmpty) {
                            return 'Please Re-enter Mpin';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            changeMpin == false ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      if(pass.text == confirmPass.text){
                        var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'set_mpin'));
                        request.fields.addAll({'user_id': App.localStorage.getString("userId").toString(),
                          'mpin': '${confirmPass.text}'});
                        print(request);
                        print(request.fields.toString() + "ssss");
                        http.StreamedResponse response = await request.send();
                        if (response.statusCode == 200) {
                          Fluttertoast.showToast(msg: "Success");
                          Navigator.pop(context);
                          App.localStorage.setString("pin", confirmPass.text);
                        } else {
                          Fluttertoast.showToast(msg: "Failed");
                        }
                      }else{
                        Fluttertoast.showToast(msg: "Please Enter same m-pin");
                      }
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
                        "SetM Pin",
                        style: TextStyle(color: colors.white1, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      if(pass.text == confirmPass.text){
                        var request = http.MultipartRequest('POST', Uri.parse(baseUrl1 + 'change_mpin'));
                        request.fields.addAll({'user_id': App.localStorage.getString("userId").toString(),
                          'mpin': '${pass.text}','new_mpin' : '${confirmPass.text}'});
                        print(request);
                        print(request.fields.toString() + "ssss");
                        http.StreamedResponse response = await request.send();
                        if (response.statusCode == 200) {
                          App.localStorage.setString("pin", confirmPass.text);

                          Fluttertoast.showToast(msg: "Success");
                          Navigator.pop(context);
                        } else {
                          Fluttertoast.showToast(msg: "Failed");
                        }
                      }else{
                        Fluttertoast.showToast(msg: "Please Enter same  m-pin");
                      }
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
                        "Change SetM Pin",
                        style: TextStyle(color: colors.white1, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

        /*    Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                width: 200,
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        if(pass.text == confirmPass.text){

                        }
                      }
                    }, child: Text("Set Pin")),
              ),*/

          ],
        ),
      ),
    );
  }
}
