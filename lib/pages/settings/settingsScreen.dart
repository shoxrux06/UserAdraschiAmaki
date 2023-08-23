import 'package:afisha_market/pages/settings/components/confidentality.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        title: Text(
          l10n?.settings??'',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: Image.asset('assets/icons/person_i.png', color: blueColor),
              title: Text(l10n?.profile??''),
              onTap: () {
                Navigator.pushNamed(context, '/updateProfile');
              },
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              leading: Image.asset('assets/icons/network.png', color: blueColor),
              title: Text(l10n?.language??'',),
              onTap: () {
                Navigator.pushNamed(context, '/chooseLang');
              },
            ),
            const Divider(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}
