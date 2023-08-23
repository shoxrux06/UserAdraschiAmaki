import 'package:afisha_market/pages/introduction/languageScreen.dart';
import 'package:afisha_market/pages/profile/about_us_page.dart';
import 'package:afisha_market/pages/profile/share_screen.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'contact_with_us.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AboutUsPage()));
                },
                child: item(l10n?.aboutUs ?? '', Icons.info,),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseLanguageScreen()));
              },
              child: item(l10n?.language ?? '', Icons.language,),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShareScreen()));
              },
              child: item(l10n?.share ?? '', Icons.share,),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ContactWithUs()));
              },
              child: item(l10n?.contactWithUs ?? '', Icons.phone,),
            ),
          ],
        ),
      ),
    );
  }

  Widget item(String text, IconData icon){
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
                SizedBox(width: 8,),
                Text(text)
              ],
            ),
            SizedBox(height: 12,),
            Divider(height: 2,color: Color(0xFFF5F5F5),),
          ],
        )
    );
  }
}
