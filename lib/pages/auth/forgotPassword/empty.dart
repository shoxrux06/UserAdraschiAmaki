import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/source/remote/request/SignInRequest.dart';
import '../../utils/utils.dart';

class ForgotEmpty extends StatefulWidget {
  final phoneNumber;

  const ForgotEmpty({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<ForgotEmpty> createState() => _ForgotEmptyState();
}
/*
  void _submitForm(Bloc bloc) {
    var phoneNumber = _phoneController.text;
    bloc.add(ForgotPasswordEventWithRequest(
        ForgotPasswordRequest(phone: phoneNumber)));
    Navigator.pushNamed(context, '/otp', arguments: phoneNumber);
  }
 */

class _ForgotEmptyState extends State<ForgotEmpty> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: MyText(
            "Something went wrong",
          )));
        }
      },
      builder: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushNamed(context, '/otp', arguments: widget.phoneNumber);
        }
        return const SizedBox();
      },
    );
  }
}
