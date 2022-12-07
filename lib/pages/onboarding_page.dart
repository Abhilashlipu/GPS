import 'package:eagle_eye/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              
              title: 'Start Your Journey',
              body: '!! Go anywhere you want to go !!',
              image: buildImage('assets/images/onboarding_start.gif'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Measure Your Speed',
              body: '!! Know your Mileage !!',
              image: buildImage('assets/images/onboarding_speed.gif'),
              decoration: getPageDecoration(),
            ),
            // PageViewModel(
            //   title: 'Security',
            //   body: '!! Track Your Vehicle and know your current location !!',
            //   image: buildImage('assets/images/Onboarding3.png'),
            //   decoration: getPageDecoration(),
            // ),
            PageViewModel(
              title: 'Engine off-on',
              body: '!! You can start and stop ignition of your Vehicle !!',
              image: buildImage('assets/images/onboarding_ignition.gif'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text(
            'Next',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.blue[900]),
          ),
          onDone: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          showSkipButton: true,
          skip: Text(
            'Skip',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900]),
          ),
          onSkip: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          next: Icon(
            Icons.arrow_forward,
            color: Colors.blue[900],
            size: 30,
          ),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor: Colors.white, //Theme.of(context).primaryColor,
          // isProgress: false,
          // isProgressTap: false,
          // showNextButton: false,
          animationDuration: 1000,
          //freeze: true,
        ),
      );
  Widget buildImage(String path) => Center(
        child: Image.asset(
          path,
          width: 350,
        ),
      );
  DotsDecorator getDotDecoration() => DotsDecorator(
      color: Colors.blue,
      activeColor: Colors.blue,
      size: Size(15, 15),
      activeSize: Size(25, 15),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ));
  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: Colors.indigo[900]),
        bodyTextStyle: TextStyle(fontSize: 20, color:Colors.indigo[900]),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
        fullScreen: false
      );
}
