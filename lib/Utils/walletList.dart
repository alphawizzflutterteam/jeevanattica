import 'package:atticadesign/Utils/constant.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../Helper/Color.dart';
import '../Model/UserDetailsModel.dart';
import 'Common.dart';

class WalletList extends StatefulWidget {
  const WalletList({Key? key}) : super(key: key);

  @override
  State<WalletList> createState() => _WalletListState();
}

class _WalletListState extends State<WalletList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Color(0xFF0F261E),
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
        title: Text("My Wallet"),
        actions: [
          /* Image.asset(
            "assets/images/shop.png",
            height: 15,
            width: 20,
          ),*/
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotiPage()),
              // );
            },

            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                "assets/images/well.png",
                height: 15,
                width: 20,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child:FutureBuilder(
            future: userDetails(App.localStorage.getString("userId").toString()),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData && snapshot.data != null) {
                UserDetailsModel wallet = snapshot.data;
                String totalbslane = '0', goldwallet = "0", silverwallet = "0";

                if(wallet != null && wallet.data != null
                    && wallet.data![0] != null ){
                  if(wallet.data![0].balance != null ){
                    totalbslane = wallet.data![0].balance!;
                  }
                  if(wallet.data![0].goldWallet != null ){
                    goldwallet = wallet.data![0].goldWallet!;
                  }
                  if(wallet.data![0].silverWallet != null ){
                    silverwallet = wallet.data![0].silverWallet!;
                  }
                }
                return Column(
                  children: [
                    Text("Balance $totalbslane"),
                    Text("gold $goldwallet"),
                    Text("Silver $silverwallet"),
                  ],
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            })


      ),


    );
  }
}
