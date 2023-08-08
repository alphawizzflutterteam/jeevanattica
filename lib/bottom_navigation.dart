import 'package:atticadesign/Helper/myAccount.dart';
import 'package:atticadesign/Helper/myCart.dart';
import 'package:atticadesign/Helper/myLocker.dart';
import 'package:atticadesign/HomePage.dart';
import 'package:atticadesign/goldcoinbar.dart';
import 'package:atticadesign/screen/jelerry.dart';
import 'package:atticadesign/screen/scan_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Helper/Color.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  int _selectedIndex = 0;
  static const TextStyle optionStyle =

      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    GoldCoinBar(),
    ScanPay(),
   // jewerry(),
    MyLocker(),
    MyAccount()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Exit"),
            content: Text("Are you sure you want to exit?"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colors.secondary2
                ),
                child: Text("YES"),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: colors.secondary2
                ),
                child: Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
    return true;
    },
     child:
      Scaffold(
      /*body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),*/
      // _widgetOptions.elementAt(_selectedIndex),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xffE0BE41),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.green
            ),

            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/Icons1.png'),
              ),
              label: 'Gold Coin/Bar',
              // backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/scan.png'
                    //'assets/homepage/jewelry.png'
                  ),
              ),
              label: 'Scan & Pay',
              // backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/Group58969.png'),
              ),
              label: 'Digital Locker',
              // backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: Icon(Icons.perm_identity),
              label: 'My Account',
              // backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: colors.blackTemp,
          unselectedItemColor: Color(0xffA1882E),
          // unselectedIconTheme: IconThemeData(color: Colors.grey),
          // iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    }
        /* body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.yellow,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
                icon: Icon(Icons.home),
                label: 'Home',
                // backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/Icons1.png'),
              ),
              label: 'Gold Coin/Bar',
                // backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/icon2.png'),
              ),
              label: 'Cart',
              // backgroundColor: Colors.blue,
            ),

            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
              icon: ImageIcon(
                AssetImage('assets/homepage/Group58969.png'),
              ),
              label: 'My Locker',
              // backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffE0BE41),
             icon: Icon(Icons.perm_identity),
              label: 'My Account',
              // backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Color(0xffA1882E),
         // unselectedIconTheme: IconThemeData(color: Colors.grey),
          // iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),*/
        /*bottomNavigationBar: BottomNavigationBar(
    items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    backgroundColor:colors.secondary2,
    icon: InkWell(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  HomePage()),
    );
    },
    child: ImageIcon(
    AssetImage("assets/homepage/house.png"),
    // color: Color(0xFF000000),
    ),
    ),
    label: 'Home',
    ),
    BottomNavigationBarItem(
    backgroundColor:colors.secondary2,
    icon: InkWell(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  GoldCoinBar()),
    );
    },
    child: ImageIcon(
    AssetImage("assets/homepage/Group 58955.png"),
    // color: Color(0xFF000000),
    ),
    ),
    label: 'Gold Coin/Bar',
    ),
    BottomNavigationBarItem(
    backgroundColor:colors.secondary2,
    icon: InkWell(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyCart()),
    );
    },
    child: ImageIcon(
    AssetImage("assets/homepage/icon2.png"),
    // color: Color(0xFF000000),
    ),
    ),
    label: 'Cart',
    ),
    BottomNavigationBarItem(
    backgroundColor:colors.secondary2,
    icon: InkWell(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyLocker()),
    );
    },
    child: ImageIcon(
    AssetImage("assets/homepage/Group58969.png"),
    // color: Color(0xFF000000),
    ),
    ),
    label: 'My Locker',
    ),
    BottomNavigationBarItem(
    backgroundColor:colors.secondary2,
    icon: InkWell(
    onTap: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyAccount()),
    );
    },
    child: ImageIcon(
    AssetImage("assets/homepage/user.png"),
    // color: Color(0xFF000000),
    ),
    ),
            label: 'My Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        onTap: _onItemTapped,
      ),*/
        );
  }
}
