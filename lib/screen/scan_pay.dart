import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../Helper/Color.dart';
import '../Model/scan_and_proceed.dart';
import '../Provider/live_price_provider.dart';

class ScanPay extends StatefulWidget {
  const ScanPay({Key? key}) : super(key: key);

  @override
  State<ScanPay> createState() => _ScanPayState();
}

class _ScanPayState extends State<ScanPay> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller ;

  @override
  void initState() {
    super.initState();
    _onQRViewCreated;


  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  String? gold1;
  String? gold2;
  @override
  Widget build(BuildContext context) {
     gold1 = Provider.of<LivePriceProvider>(context).gold1;
     gold2 = Provider.of<LivePriceProvider>(context).gold2;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 200,),
          Container(
            padding: EdgeInsets.all(10),
            width: 326,
            height: 326,
            decoration: BoxDecoration(
              color: colors.secondary2,
              border: Border.all(color: colors.blackTemp),
              borderRadius: BorderRadius.circular(10)
            ),
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: () {
                //_onQRViewCreated(controller!);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanTransaction(
                //   goldRate: livePrice.gold1.toString(),
                //   gold1Rate: livePrice.gold2.toString(),
                // )));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BuyDigitalGold(
                //       goldRate: livePrice.gold1.toString(),
                //       gold1Rate : livePrice.gold2.toString()
                //
                //   )),
                // );
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffF1D459), Color(0xffB27E29)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                height: 45,
                width: MediaQuery.of(context).size.width-150,
                child: Center(
                  child: Text(
                    "Scan & Pay",
                    style: TextStyle(color: colors.white1, fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Center(
          //     child: (result != null)
          //         ? Text(
          //         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
          //         : Text('Scan a code'),
          //   ),
          // )
        ],
      ),
    );
  }

   _onQRViewCreated( QRViewController controller) {

    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if(result != null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanTransaction(
          goldRate: gold1.toString(),
          gold1Rate: gold2.toString(),
        )));
        controller.dispose();
      }

    });

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}


