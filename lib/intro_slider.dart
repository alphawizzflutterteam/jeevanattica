// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Color.dart';
import '../authentication/login.dart';

class Introslider extends StatefulWidget {
  const Introslider({Key? key}) : super(key: key);

  @override
  State<Introslider> createState() => _IntrosliderState();
}

class _IntrosliderState extends State<Introslider> {
  PageController? _pageController;
  int currentIndex = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  nextFunction() {
    _pageController?.nextPage(duration: _kDuration, curve: _kCurve);
    if (currentIndex == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.primary,
        body: Stack(
          children: [
            PageView(
              onPageChanged: onChangedFunction,
              controller: _pageController,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 100),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/onboarding/introimage_a.png",
                            height: 500,
                            width: 500,
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Text(
                              "Safe Investment with easy gold management",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontSize: 20,
                                  fontFamily: 'Helvetica Neue LT Pro',
                                  fontWeight: FontWeight.w600,
                                  color: colors.blackTemp),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 100),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/onboarding/introimage_b.png",
                            height: 500,
                            width: 500,
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            "Buy/Sell high quality 99.99% 24K digital gold",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Helvetica Neue LT Pro',
                                fontWeight: FontWeight.w600,
                                color: colors.blackTemp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20, top: 100),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/onboarding/introimage_c.png",
                            height: 500,
                            width: 500,
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: Text(
                            "We give assurance for 100% Purity of your digital gold",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Helvetica Neue LT Pro',
                                fontWeight: FontWeight.w600,
                                color: colors.blackTemp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            currentIndex == 2
                ? SizedBox.shrink()
                : Positioned(
                    top: 40,
                    right: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(
                                color: colors.grad1Color,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          )),
                    )),
            Positioned(
              bottom: 200,
              left: 100,
              right: 100,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    positionIndex: 0,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 1,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 2,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              left: 30,
              child: Container(
                child: InkWell(
                    onTap: () => nextFunction(),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xffF1D459), Color(0xffB27E29)]),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: currentIndex == 0
                          ? Text(
                              "NEXT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colors.primary2, fontSize: 18),
                            )
                          : currentIndex == 1
                              ? Text("NEXT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: colors.primary2, fontSize: 18))
                              : Text("GET STARTED",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: colors.primary2, fontSize: 18)),
                    )),
              ),
            )
          ],
        )
        );
  }

  Widget Pages(
      {images,
      title,
      content,
      indicators,
      button,
      reverse = false,
      pageIndex}) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              !reverse
                  ? Container(
                      child: Image.asset(
                        images,
                        height: 500,
                        width: 500,
                      ),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                    )
                  : SizedBox(),
              Container(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Helvetica Neue LT Pro',
                      fontWeight: FontWeight.w600,
                      color: colors.primary),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Helvetica Neue LT Pro',
                      // fontWeight: FontWeigh,
                      color: colors.black54),
                ),
              ),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  int? positionIndex, currentIndex;
  Indicator({this.currentIndex, this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 10,
        width: currentIndex == positionIndex ? 10 : 10,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: positionIndex == currentIndex ? colors.secondary2 : Colors.grey,
        ),
      ),
    );
  }
}
