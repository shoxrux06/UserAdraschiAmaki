import 'dart:async';
import 'package:afisha_market/pages/main_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../core/bloc/language/language_bloc.dart';
import '../../core/bloc/language/language_event.dart';
import '../../core/utils/local_storage.dart';
import '../utils/const.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
      return Scaffold(
        body: Container(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          child: Column(
            children: [
              const Spacer(),
              MyText(
                "${AppLocalizations.of(context)?.welcome}",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: mainColor,
              ),
              const Spacer(),
              MyButtonTwo(
                "Русский",
                onTap: () async {
                  context.read<LanguageBloc>().add(const ChangeLanguage(langCode: 'ru'));
                  await LocalStorage.instance.setLanguage('ru');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer()));
                },
              ),
              MyButtonTwo(
                'O\'zbek',
                onTap: () async{
                  context.read<LanguageBloc>().add(const ChangeLanguage(langCode: 'uz'));
                  await LocalStorage.instance.setLanguage('uz');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer()));
                },
              ),
              const Spacer(flex: 2,),
            ],
          ),
        ),
      );
    });
  }
}
