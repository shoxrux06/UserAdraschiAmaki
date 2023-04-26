import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/auth/signIn/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/const.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => AuthBloc(authRepository),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Войти',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
              ),
            ),
            body: const SignInButton())
    );
  }
}
