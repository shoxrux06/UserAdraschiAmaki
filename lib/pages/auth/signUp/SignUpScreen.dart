import 'package:afisha_market/pages/auth/signUp/formContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.isFromCart = false}) : super(key: key);
  final bool isFromCart;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)?.signUpText ?? '',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: SignUpContainer(isFromCart: widget.isFromCart),
      ),
    );
  }
}
