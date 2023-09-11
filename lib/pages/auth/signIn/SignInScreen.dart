import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/constants/app_routes.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/bloc/auth/authEvent.dart';
import '../../../core/data/source/remote/request/SignInRequest.dart';
import '../../utils/const.dart';
import '../../utils/custom_button.dart';
import '../../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, this.isFromCart = false}) : super(key: key);

  final bool isFromCart;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)?.signIn ?? '',
          ),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isAuthenticated && (state.isErrorOccurred == false)) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer(isFromCartPage: widget.isFromCart,)));
            }
          },
          builder: (context, state) {
            return LayoutBuilder(builder: (context, constraints){
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          child: Column(
                            children: [
                              MyTextFormField2(
                                l10n?.usernameOrPhoneNumber ?? '',
                                const Icon(CupertinoIcons.person),
                                _phoneController,
                                validator: (val) {
                                  if (val!.length < 3) return 'UserName must be at least 3 characters';
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField2(
                                l10n?.password ?? '',
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
                                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                                  },
                                  child: MyText(
                                    l10n?.forgotPassword ?? '',
                                    color: blueColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              CustomButton(
                                l10n?.signIn ?? '',
                                isLoading: state.isAuthenticating,
                                onTap: () {
                                  context.read<AuthBloc>().add(
                                    SignInEvent(
                                      context,
                                      SignInRequest(
                                        login: _phoneController.text,
                                        password: _passController.text,),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        )
    );
  }
}
