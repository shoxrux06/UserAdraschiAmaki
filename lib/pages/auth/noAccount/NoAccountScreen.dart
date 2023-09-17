import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import '../signUp/SignUpScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NoAccountScreen extends StatefulWidget {
  const NoAccountScreen({Key? key}) : super(key: key);

  @override
  State<NoAccountScreen> createState() => _NoAccountScreenState();
}

class _NoAccountScreenState extends State<NoAccountScreen> {

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                l10n?.signUpText ?? '',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SignUpScreen(),
                    ),
                  );
                },
              ),
              MyButton(
                l10n?.signIn ?? '',
                onTap: () {
                  Navigator.pushNamed(context, '/signIn');
                },
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: MyText(
                  l10n?.signInToPost ?? '',
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
 */
