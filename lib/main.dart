
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'helpers/ColorsSys.dart';
import 'helpers/AppConstants.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Text('Skip', style: TextStyle(
              color: ColorSys.gray,
              fontSize: 18,
              fontWeight: FontWeight.w400
            ),),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                image: 'assets/images/food.png',
                title: AppConstants.stepOneTitle,
                content: AppConstants.stepOneContent
              ),
              makePage(
                reverse: true,
                image: 'assets/images/delivery.png',
                title: AppConstants.stepTwoTitle,
                content: AppConstants.stepTwoContent
              ),
              makePage(
                image: 'assets/images/cardpay.png',
                title: AppConstants.stepThreeTitle,
                content: AppConstants.stepThreeContent
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse ? 
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              const SizedBox(height: 30,),
            ],
          ) : const SizedBox(),
          Text(title, style: TextStyle(
            color: ColorSys.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),),
          const SizedBox(height: 20,),
          Text(content, textAlign: TextAlign.center, style: TextStyle(
            color: ColorSys.gray,
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),),
          reverse ? 
          Column(
            children: <Widget>[
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ) : const SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: ColorSys.secoundry,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
