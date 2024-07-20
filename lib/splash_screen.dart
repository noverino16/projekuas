import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projekuas/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OnBoardingScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF786BDA),Color(0xffF5F5F5)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("gambar/logo.png"), // Perbaikan path gambar
            ),
            SizedBox(height: 20), // Menambahkan ruang antara gambar dan teks
            Text(
              'LOKERKU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold, // Penyesuaian ukuran font
              ),
            ),
          ],
        ),
      ),
    );
  }
}
