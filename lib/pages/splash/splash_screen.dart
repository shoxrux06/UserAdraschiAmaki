import 'dart:async';
import 'package:afisha_market/pages/main_container.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainContainer()));
        // Navigator.of(context).pushReplacement(fade(page:isRegistred ? const HomeScreen() : const Onboarding()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset('assets/images/screenImage.png')),
          ),
          Lottie.asset(
            'assets/images/loading.json',
            width: 64,
            height: 64,
          ),
        ],
      ),
    );
  }
}
