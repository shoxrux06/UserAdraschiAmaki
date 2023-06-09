import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/pages/auth/forgotPassword/empty.dart';
import 'package:afisha_market/pages/profile/delete_account_confirm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/auth/authBloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../auth/signUp/widgets/country_text_form_field.dart';
import '../auth/signUp/widgets/masked_text_controller.dart';
import '../utils/const.dart';
import '../utils/custom_button.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = MaskedTextController(
    mask: '+000 (00) 000-00-00',
  );

  @override
  void initState() {
    _phoneController.text = '+998';
    final val = TextSelection.collapsed(offset: _phoneController.text.length);
    _phoneController.selection = val;
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state.isSentRequestDeleteAccount){
          final phone = _phoneController.text
              .replaceAll(' ', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll('-', '');
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=> DeleteAccountConfirmPage(phone: phone)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${AppLocalizations.of(context)?.deleteAccount}'),
          ),
          body: Form(
              key: _formKey,
              child: Container(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      CountryTextFormField(
                        l10n?.phoneNumber ?? '',
                        const Icon(CupertinoIcons.phone),
                        _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: MyText(
                            l10n?.enterYourPhoneNumberToReceiveVerificationCode ??
                                '',
                            color: mainColor,
                            textAlign: TextAlign.center,
                          )),
                      const Spacer(),
                      const ForgotEmpty(),
                      CustomButton(
                        l10n?.next ?? '',
                        isLoading: state.isSendingRequestDeleteAccount,
                        onTap: () {
                          final phone = _phoneController.text
                              .replaceAll(' ', '')
                              .replaceAll('(', '')
                              .replaceAll(')', '')
                              .replaceAll('-', '');
                          context.read<AuthBloc>().add(DeleteAccountEvent(context, phone));
                        },
                      )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
