import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoAccountScreen extends StatefulWidget {
  const NoAccountScreen({Key? key}) : super(key: key);

  @override
  State<NoAccountScreen> createState() => _NoAccountScreenState();
}

class _NoAccountScreenState extends State<NoAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              'signUp',
              onTap: () {
                Navigator.pushNamed(context, '/signUp');
              },
            ),
            MyButton(
              'signIn',
              onTap: () {
                Navigator.pushNamed(context, '/signIn');
              },
            ),
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: MyText(
                'signInToPost',
                color: Colors.black,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
 */
