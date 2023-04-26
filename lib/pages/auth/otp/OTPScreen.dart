import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/auth/otp/otp_container.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/auth/authBloc.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context)!.settings;
    var phoneNumber = settings.arguments as String;
    return BlocProvider(
        create: (_) => AuthBloc(authRepository),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                '',
                style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
              ),
            ),
            body: OTPContainer(
              phone: phoneNumber,
            )));
  }
}
