import 'dart:async';

import 'package:flutter/material.dart';
import 'package:potrico/constants/colors.dart';
import 'package:potrico/screens/onboarding/login.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginUser(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
            colors: [
            gradient1,
            gradient2
          ])
        ),
        child: Center(
          child: Image.asset("assets/images/Layer_1.png"),
        ),
      ),
    );
  }
}