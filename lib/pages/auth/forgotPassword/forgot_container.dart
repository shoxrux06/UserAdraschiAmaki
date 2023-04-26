import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/data/source/remote/request/ForgotPasswordRequest.dart';
import 'package:afisha_market/pages/auth/forgotPassword/empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/auth/authBloc.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';

class ForgotPasswordContainer extends StatefulWidget {
  const ForgotPasswordContainer({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordContainer> createState() =>
      _ForgotPasswordContainerState();
}

class _ForgotPasswordContainerState extends State<ForgotPasswordContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc _bloc = BlocProvider.of<AuthBloc>(context);
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              MyTextFormField2(
                'Номер телефона',
                const Icon(CupertinoIcons.phone),
                _phoneController,
                validator: (val) {
                  if (val!.length != 13 && val[0] == '+')
                    return 'Phone number must be like +998901234567';
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MyText(
                "Введите номер телефона для получения кода подтвержления",
                color: mainColor,
                textAlign: TextAlign.center,
              )),
              const Spacer(),
              ForgotEmpty(
                phoneNumber: _phoneController.text,
              ),
              MyBigButton(
                'Далее',
                onTap: () {
                  _bloc.add(ForgotPasswordEvent(
                      ForgotPasswordRequest(phone: _phoneController.text)));
                },
              )
            ],
          ),
        ));
  }
}
