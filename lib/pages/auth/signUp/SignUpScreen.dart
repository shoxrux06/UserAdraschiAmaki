import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/auth/signUp/formContainer.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/auth/authBloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AuthBloc(authRepository),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Регистрация',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
              ),
            ),
            body: const SignUpContainer()));
  }
}
