import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Utils/Razorpay.dart';

class WalletAndRazorPage extends StatefulWidget {
  const WalletAndRazorPage({Key? key}) : super(key: key);

  @override
  State<WalletAndRazorPage> createState() => _WalletAndRazorPageState();
}

class _WalletAndRazorPageState extends State<WalletAndRazorPage> {

  List categories = [
    " ₹ 1000 ",
    " ₹ 2000 ",
    " ₹ 5000 ",
  ];
  List selectedCategories = [];
  TextEditingController choiceAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F261E),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF15654F),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.secondary2,
          ),

        ),
        title: Text("Wallet Topup"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Topup wallet",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: choiceAmountController,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "₹ Enter Amount",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: '₹ Enter Amount',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: [
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('1000',
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController.text == '1000',
                        onSelected: (bool selected) {
                          setState(() {
                            choiceAmountController.text =
                            (selected ? '1000' : '');
                            print("10::---$choiceAmountController");
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('2000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colors.black54.withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        // selected: choice== 'right',
                        selected: choiceAmountController.text == '2000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("20::");
                            choiceAmountController.text =
                            (selected ? '2000' : '');
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('5000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colors.black54.withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController.text == '5000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("50::");
                            choiceAmountController.text =
                            (selected ? '5000' : '');
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(25),
                                right: Radius.circular(25))),
                        side: BorderSide(width: 1, color: Color(0xff0C3B2E)),
                        backgroundColor: Color(0xff15654F),
                        label: Text('10000',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colors.black54.withOpacity(0.5),
                                fontSize: 20)),
                        labelPadding: EdgeInsets.symmetric(horizontal: 12),
                        selected: choiceAmountController.text == '10000',
                        onSelected: (bool selected) {
                          setState(() {
                            print("100::");
                            choiceAmountController.text =
                            (selected ? '10000' : '');
                          });
                        },
                        selectedColor: Color(0xff699a8d),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var a = double.parse(choiceAmountController.text.toString()) * 100;
                RazorPayHelper razorHelper=new RazorPayHelper(
                    a.toString(),
                    context, (result){}, "curUserId", "resultGram.toString()", false, false);
                razorHelper.init(true, amount: a.toString(), addAmointTr: true);
                /*  var a = await addAmount(choiceAmountController.text);
                if (a != null) {
                  showDialog(
                    context: context,
                    builder: (ctxt) => new AlertDialog(
                      title: Text("${a.message}"),
                      actions: [
                        GestureDetector(
                          child: Center(child: Text("Okay")),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                }*/
              },
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffF1D459), Color(0xffB27E29)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  height: 45,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Text(
                      "PROCEED TO TOPUP",
                      style: TextStyle(color: colors.white1, fontSize: 15),
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