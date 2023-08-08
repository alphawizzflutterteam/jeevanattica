import 'package:flutter/material.dart';
class TransactionDialogBox extends StatefulWidget {
  const TransactionDialogBox({Key? key}) : super(key: key);

  @override
  State<TransactionDialogBox> createState() => _TransactionDialogBoxState();
}

class _TransactionDialogBoxState extends State<TransactionDialogBox> {
  @override
  Widget build(BuildContext context) {
  return  Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 380,
                color: Color(0xff0C3B2E),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Text("Select date",style: TextStyle(color: Colors.orange),),
                      trailing: Icon(Icons.clear_rounded,color: Colors.white,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Start date",style: TextStyle(color: Colors.white),),

                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xff376356),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 17),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xffFFFFFFF)),
                                hintText: 'DD/MM/YY',
                                suffixIcon: Icon(Icons.calendar_today_outlined,color: Colors.orange,size: 20,)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("Start date",style: TextStyle(color: Colors.white),),

                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xff376356),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 36,
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 17),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  hintStyle: TextStyle(color: Color(0xffFFFFFFF)),
                                  hintText: 'DD/MM/YY',
                                  suffixIcon: Icon(Icons.calendar_today_outlined,color: Colors.orange,size: 20,)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 100, right: 100, top: 30, bottom: 20),
                      child: ElevatedButton(
                        child: Text('APPLY',style: TextStyle(color: Color(0xff0F261E),fontSize: 20),),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const AccountHolderDetailscontinues()),
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFB27E29),
                            fixedSize: Size(180,60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            textStyle:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),



                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}



