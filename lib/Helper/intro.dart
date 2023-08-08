import 'package:atticadesign/Utils/Common.dart';
import 'package:atticadesign/Utils/constant.dart';
import 'package:atticadesign/authentication/login.dart';
import 'package:atticadesign/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'Color.dart';
import 'Session.dart';
class IntroImage extends StatefulWidget {
  @override
  _IntroImageState createState() => _IntroImageState();
}

class _IntroImageState extends State<IntroImage> {
  late PageController _pageController;
  int currentIndex = 0;
  bool _isVisible = false;
  String nexttext = "NEXT";
  String skiptext = "Skip";
  // void showToast() {
  //   print(currentIndex);
  //  if(currentIndex== 0 && currentIndex ==1){
  //    setState(() {
  //      _isVisible = _isVisible;
  //    });
  //  }
  //  else {
  //    setState(() {
  //      _isVisible = !_isVisible;
  //    });
  //  }

  // }
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    changePage();
    // showToast();
  }
  changePage()async{
    await App.init();
    print(App.localStorage.getString("userId"));
    if(App.localStorage.getString("userId")!=null){

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> BottomBar()), (route) => false);
    }else{
    }
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/onboarding/int1.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

            Visibility (
            visible: currentIndex == 2 ? false : true,
                child:InkWell(
                  child:Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      '$skiptext',
                      style: TextStyle(
                          color:colors.secondary2,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  onTap: () {
                    print('yess3333');
                    // setPrefrenceBool("ISFIRSTTIME", false);
                    // setState(() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>const LoginPage()),
                    //
                    // );
                    print('yess');
                    // });
                  },


                ),
            )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                makePage(
                  image: 'assets/onboarding/introimage_a.png',
                  title: "",
                  content: "Safe Investment with easy gold management",
                ),
                makePage(
                    image: 'assets/onboarding/introimage_b.png',
                    title: "",
                    content: "Safe Investment with easy gold management"),
                makePage(
                    image: 'assets/onboarding/introimage_c.png',
                    title: "",
                    content:
                        "We give assurance for 100% Purity of your digital gold"),
              ],
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: _buildIndicator(),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(height: 30),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),

// if(currentIndex==3){
//   Padding(
//     padding: const EdgeInsets.only(top: 50),
//     child: ElevatedButton(
//       child: Text('Generated',style: TextStyle(color: Colors.black87,fontSize: 20),),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) =>  LoginPage()),
//         );
//       },
//       style: ElevatedButton.styleFrom(
//           primary:colors.secondary2,
//           // fixedSize: Size(50, 30  ),
//           minimumSize: const Size(300, 50),
//           maximumSize: const Size(300, 50),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
//           textStyle: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.bold)),
//     ),
//   ),
// }else{
          SizedBox(height: 60),
          Container(
            width: 300,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
              ),
              onPressed: () {
// print("print " + currentIndex.toString());
// _pageController = PageController(initialPage: 1);
                if (currentIndex == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  // Navigator.push(
                  currentIndex++;
                  setState(() {
                    currentIndex = currentIndex;
                    _pageController = PageController(initialPage: currentIndex);
                    // controller: _pageController,

                    // _pageController = PageController(initialPage: currentIndex);
                  });
                  // );
                }

                // else{
                //   currentIndex++;
                // }
              },
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffF1D459), Color(0xffB27E29)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    "$nexttext",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff0F261E).withOpacity(1)),
                  ),
                ),
              ),
            ),
          ),

          /* Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                   colors.secondary2,
                    Color(0xffB27E29)
                  ]
                )
              ),
              child: ElevatedButton(
                // if(currentIndex)
                child: Text(
                  '$nexttext',
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    // primary:colors.secondary2,
                    // fixedSize: Size(50, 30  ),
                    minimumSize: const Size(300, 50),
                    maximumSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),*/
// }
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 10 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.yellow),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));

        if (currentIndex == 2) {
          nexttext = "GET STARTED";
        } else {
          nexttext = "NEXT";
        }

        // print("count:: "+currentIndex.toString());
        if (currentIndex == 3) {
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color:colors.secondary2,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        } else {}
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
