import 'package:afisha_market/core/bloc/language/language_bloc.dart';
import 'package:afisha_market/core/data/models/language_model.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final bloc = LanguageBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder(builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              const Spacer(),
              MyText(
                "Добро пожаловать",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: mainColor,
              ),
              const Spacer(),
              MyButtonTwo(
                "Русский",
                onTap: () {
                  bloc.add(
                      ToggleLanguageEvent(Languages.languages[1]));
                  Navigator.of(context).pop();
                },
              ),
              MyButton(
                "English",
                onTap: () {
                  bloc.add(
                      ToggleLanguageEvent(Languages.languages[0]));
                  Navigator.of(context).pop();
                },
              ),
              MyButtonTwo(
                'O\'zbek',
                onTap: () {
                  bloc.add(
                      ToggleLanguageEvent(Languages.languages[2]));
                  Navigator.of(context).pop();
                },
              ),
              const Spacer(flex: 2,),
            ],
          ),
        );
      }),
    );
  }
}
