import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/Screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 245, 247, 255),
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_pic.jpg',
                fit: BoxFit.cover,
                height: height * 0.45,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                'TOP HEADLINES',
                style: GoogleFonts.anton(
                    fontSize: height * 0.055,
                    letterSpacing: .6,
                    color: Colors.grey.shade700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              const SpinKitChasingDots(
                color: Colors.blue,
                size: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
