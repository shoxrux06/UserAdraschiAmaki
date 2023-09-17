import 'package:afisha_market/core/constants/app_routes.dart';
import 'package:afisha_market/pages/introduction/languageScreen.dart';
import 'package:afisha_market/pages/profile/about_us_page.dart';
import 'package:afisha_market/pages/profile/share_screen.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/bloc/cart/cart_bloc.dart';
import '../../core/bloc/cart/cart_event.dart';
import '../../core/utils/local_storage.dart';
import '../main_container.dart';
import 'contact_with_us.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String token = LocalStorage.instance.getToken();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    print('token <<$token>>');
    return SafeArea(
      child: Scaffold(
          body:  SingleChildScrollView(
            child: Column(
              children: [
                token.isEmpty? Container():Container(
                  width: double.infinity,
                  color: blueColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24,),
                      Text('Shaxsiy kabinet',style: TextStyle(color: mainColor, fontSize: 24),),
                      SizedBox(height: 12,),
                      Image.asset('assets/icons/logo.png', width: 100,height: 80,),
                      SizedBox(width: 12,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${LocalStorage.instance.getUserName()}', style: TextStyle(color: mainColor, fontSize: 14),),
                          Text('${LocalStorage.instance.getUserPhone()}',style: TextStyle(color: mainColor, fontSize: 14),),
                        ],
                      ),
                      SizedBox(height: 24,),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      token.isNotEmpty? Container():Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: mainColor, width: 2),
                            borderRadius: BorderRadius.circular(120)),
                        width: 120,
                        height: 120,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: Image.asset('assets/icons/logo.png', fit: BoxFit.cover,width: 120,height: 120,),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const ChooseLanguageScreen()));
                        },
                        child: item(
                          l10n?.language ?? '',
                          Icons.language,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ShareScreen()));
                        },
                        child: item(
                          l10n?.share ?? '',
                          Icons.share,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const ContactWithUs()));
                        },
                        child: item(
                          l10n?.contactWithUs ?? '',
                          Icons.phone,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AboutUsPage()));
                        },
                        child: item(
                          l10n?.aboutUs ?? '',
                          Icons.info,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomButtonTwo(
                        token.isNotEmpty? l10n?.logOut ?? '':l10n?.signInAccount ?? '',
                        onTap: token.isNotEmpty? (){
                          _logout(context);
                        }:() {
                          Navigator.pushNamed(context,  AppRoutes.signIn);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      token.isNotEmpty? Container():RichText(
                        text: TextSpan(
                            text: '${l10n?.youDontHaveAccount} ',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text:'${l10n?.signUpText}',
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.pushNamed(context, AppRoutes.signUp);
                                },
                                style: TextStyle(color: blueColor),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }

  void _logout(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('${l10n?.pleaseConfirm}'),
          content: Text('${l10n?.doYouWantLogout}'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                context.read<CartBloc>().add(CartClearEvent());
                LocalStorage.instance.deleteToken();
                LocalStorage.instance.deleteUserId();
                LocalStorage.instance.deleteUsername();
                LocalStorage.instance.deleteUserPhone();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer()));
              },
              child: Text('${l10n?.yes}'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('${l10n?.no}'))
          ],
        );
      },
    );
  }

  Widget item(String text, IconData icon) {
    return Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: blueColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(text)
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 2,
              color: Color(0xFFF5F5F5),
            ),
          ],
        ));
  }
}
