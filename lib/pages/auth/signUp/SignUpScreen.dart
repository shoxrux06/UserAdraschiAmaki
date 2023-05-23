import 'package:afisha_market/core/bloc/category/category_bloc.dart';
import 'package:afisha_market/core/bloc/userProfile/user_profile_bloc.dart';
import 'package:afisha_market/core/data/source/remote/response/ProductCategoryResponse.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:afisha_market/pages/auth/signUp/formContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/auth/authBloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/data/source/remote/response/UserCategoryResponse.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, this.userCategoryResponse}) : super(key: key);

  final UserCategoryResponse? userCategoryResponse;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final bloc = CategoryBloc(categoryRepository);
  UserCategoryResponse? userCategoryResponse;
  @override
  void initState() {
    bloc.add(CategoryInitEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)?.signUpText ?? '',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(builder: (context,state){
          userCategoryResponse = state.userCategoryResponse;
          return Container(
              color: Colors.lightBlueAccent.withOpacity(0.2),
              child: SignUpContainer(userCategoryResponse: userCategoryResponse,));
        },),
      ),
    );
  }
}
