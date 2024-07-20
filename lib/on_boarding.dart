import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:projekuas/screen_page/login_screen.dart';
import 'package:projekuas/screen_page/register_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color redshoes = Colors.white;

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'SIGN UP',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50)))
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: redshoes,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Sign In',
        style: TextStyle(
          fontSize: 16,
          color: redshoes,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      },
      controllerColor: redshoes,
      totalPage: 4,
      headerBackgroundColor: Color(0xFF402E7A),
      pageBackgroundColor: Color(0xFF402E7A),
      background: [
        Center(
          child: Image.asset(
            'gambar/onboarding1.png',
            height: 400,
            width: 390,
          ),
        ),
        Center(
          child: Image.asset(
            'gambar/onboarding2.png',
            height: 400,
            width: 390,
          ),
        ),
        Center(
          child: Image.asset(
            'gambar/onboarding3.png',
            height: 400,
            width: 390,
          ),
        ),
        Center(
          child: Image.asset(
            'gambar/onboarding4.png',
            height: 400,
            width: 390,
          ),
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 400,
              ),
              Text(
                'Best Platform\nfor Job Hunter',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Dream Job, Just a Tap Away',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 400,
              ),
              Text(
                'Explore Your\nDream Job',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Unlock Your Full Potential Find the Perfect Job to Match Your Skills and Ambitions!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 400,
              ),
              Text(
                'Chase a Perfect\nCareer Path',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Transform Your Job Hunt into a Career Triumph Discover Endless Opportunities!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 400,
              ),
              Text(
                'Get the\nGood Job With Us',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Professional Journey Starts Here  Explore Jobs that Inspire Growth and Success!',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
