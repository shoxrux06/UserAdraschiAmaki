import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/splash/splash_screen.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/success.json', width: 180, height: 180),
            Padding(
              padding: const EdgeInsets.all(16),
              child: MyBigButton(
                'OK',
                onTap: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                  // Future.delayed(const Duration(milliseconds: 500), () {
                  //   setState(() {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const SplashScreen()));
                  //     // Navigator.pushReplacement(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => ChangeNotifierProvider(
                  //     //             create: (context) => HomeProvider(),
                  //     //             child: const MainContainer())));
                  //   });
                  // });
                  // Future.delayed(const Duration(milliseconds: 500), () {
                  //   setState(() {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const MainContainer()));
                  //   });
                  // });

                  // Future.delayed(Duration.zero, () {
                  //   SchedulerBinding.instance.addPostFrameCallback((_) {
                  //     Navigator.pop(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const MainContainer()));
                  //     // Navigator.popUntil(
                  //     //     context, ModalRoute.withName('/login'));
                  //     // Navigator.Navigator.of(context).pushAndRemoveUntil(
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => const MainContainer()),
                  //     //     (Route<dynamic> route) => false);
                  //   });
                  // });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
