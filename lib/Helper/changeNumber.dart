import 'package:atticadesign/Api/api.dart';
import 'package:atticadesign/Model/NumberModel.dart';
import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/authentication/otp.dart';
import 'package:flutter/material.dart';

import 'Color.dart';
import 'couponCode.dart';

class ChangeNumber extends StatefulWidget {
  const ChangeNumber({Key? key}) : super(key: key);

  @override
  State<ChangeNumber> createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  get mobileC => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xFF15654F),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primaryNew,
        //Color(0xFF15654F),
        leading: Icon(
          Icons.arrow_back,
          color: colors.secondary2,
        ),
        title: Text("Change Number"),
        actions: [
          Image.asset(
            "assets/images/shop.png",
            height: 15,
            width: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/well.png",
              height: 15,
              width: 20,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Enter New Number",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xffFFFFFF).withOpacity(0.35),
                ),
                height: 50,
                child: TextField(
                  controller: mobileC,
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 17),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: " ",
                    filled: true,
                    hintStyle: TextStyle(color:colors.secondary2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: colors.primaryNew,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Once you change the number your \ngold and data will be transferred to your new number",
                    style: TextStyle(color:colors.secondary2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/rightcheck.png",
                    height: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "I consent to change my number",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50.0,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(colors: [
                   colors.secondary2,
                    Color(0xffB27E29),
                  ])),
              child: InkWell(
                onTap: () async {
                  if (mobileC.text.isNotEmpty) {
                    var mobile = mobileC.text.toString();

                    NumberModel? numModel = await changeNumber(mobile);
                    if (numModel!.error == false) {
                      Common().toast(numModel.message.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OtpPage(otp: "",data: "",)),
                      );
                    } else {
                      Common().toast(numModel.message.toString());
                    }
                  } else {
                    Common().toast("Fill Fields");
                  }
                },
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0F261E).withOpacity(1),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
