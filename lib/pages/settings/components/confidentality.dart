import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';
class ConfidentalityScreen extends StatefulWidget {
  const ConfidentalityScreen({Key? key}) : super(key: key);

  @override
  State<ConfidentalityScreen> createState() => _ConfidentalityScreenState();
}

class _ConfidentalityScreenState extends State<ConfidentalityScreen> {
  final _oldPasswordController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(l10n?.confidentiality??''),
      ),
      body: LayoutBuilder(
        builder:(context, constraints)=> Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    MyTextFormField2(
                      l10n?.oldPassword ?? '',
                      const Icon(CupertinoIcons.lock),
                      _oldPasswordController,
                      validator: (val) {
                        if (val!.length < 5) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: 24,),
                    MyTextFormField2(
                      l10n?.newPassword ?? '',
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
                      l10n?.confirmPassword ?? '',
                      const Icon(CupertinoIcons.lock),
                      _pass2Controller,
                      validator: (val) {
                        if (val!.length < 5)
                          return 'Password must be at least 6 characters';
                        return null;
                      },
                      isPassword: true,
                    ),
                    Spacer(),
                    MyBigButton(
                      '${l10n?.edit ?? ''}',
                      onTap: () {
                        setState(() {

                        });
                      },
                    ),
                    SizedBox(height: 48,)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
