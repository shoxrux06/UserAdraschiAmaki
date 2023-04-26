import 'package:afisha_market/const.dart';
import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/auth/authBloc.dart';
import '../../utils/drop_down.dart';
import '../../utils/utils.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({Key? key}) : super(key: key);

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc _bloc = BlocProvider.of<AuthBloc>(context);
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
        print('phone from sign up empty ${AppConst.pHONENUMBER}');
        if (state is AuthSuccessState) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.pushNamed(context, '/otp',
                arguments: _phoneController.text);
          });
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      MyTextFormField2(
                        'fullName2',
                        const Icon(CupertinoIcons.person),
                        _nameController,
                        validator: (val) {
                          if (val!.length < 3)
                            return 'Name must be at least 3 characters';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        'username',
                        const Icon(CupertinoIcons.person),
                        _userNameController,
                        validator: (val) {
                          if (val!.length < 3)
                            return 'UserName must be at least 3 characters';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        'phoneNumber',
                        const Icon(CupertinoIcons.phone),
                        _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val!.length != 13 && val[0] == '+')
                            return 'Phone number must be like +998901234567';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyDropDown(),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        'password',
                        const Icon(CupertinoIcons.lock),
                        _pass1Controller,
                        validator: (val) {
                          if (val!.length < 5) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextFormField2(
                        'confirmPassword',
                        const Icon(CupertinoIcons.lock),
                        _pass2Controller,
                        validator: (val) {
                          if (val!.length < 5)
                            return 'Password must be at least 6 characters';
                          return null;
                        },
                        isPassword: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  MyBigButton(
                    'signUpText',
                    onTap: () {
                      var fullName = _nameController.text;
                      var userName = _userNameController.text;
                      var phoneNumber = _phoneController.text;
                      var pass1 = _pass1Controller.text;
                      var pass2 = _pass2Controller.text;
                      if (pass1.isEmpty && pass1 != pass2) {
                      } else {
                        AppConst.pHONENUMBER = _phoneController.text;
                        print("qqq ${_phoneController.text}");
                        _bloc.add(SignUpEvent(SignUpRequest(
                            fullname: fullName,
                            username: userName,
                            phone: phoneNumber,
                            address: 'Tashkent',
                            password: pass1,
                            passwordConfirmation: pass2)));
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
