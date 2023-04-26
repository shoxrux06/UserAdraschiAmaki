import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/data/source/remote/request/SignInRequest.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'empty.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({Key? key}) : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  late final AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/images/success.json',
                    width: 180, height: 180),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: MyBigButton(
                    'OK',
                    onTap: () {
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
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
          );

          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const Success()));

          // Navigator.pushNamed(context, '/user',
          //     arguments: SignInRequest(
          //         login: widget.phoneNumber, password: widget.pass));
        }
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                MyTextFormField2(
                  'usernameOrPhoneNumber',
                  const Icon(CupertinoIcons.person),
                  _phoneController,
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
                  'password',
                  const Icon(CupertinoIcons.lock),
                  _passController,
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
                Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgotPassword');
                        },
                        child: MyText(
                          "forgotPassword",
                          color: mainColor,
                        ))),
                // EmptySignIn(
                //   phoneNumber: _phoneController.text,
                //   pass: _passController.text,
                // ),
                const Spacer(),
                // ContainerAuth(_phoneController.text, _passController.text)
                MyBigButton(
                  'Войти',
                  onTap: () {
                    _bloc.add(SignInEvent(SignInRequest(
                        login: _phoneController.text,
                        password: _passController.text)));
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
