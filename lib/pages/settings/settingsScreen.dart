import 'package:afisha_market/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/const.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Настройки',
          style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Image.asset('assets/icons/person_i.png', color: mainColor),
            title: const Text(LocaleKeys.profile).tr(),
            onTap: () {
              Navigator.pushNamed(context, '/updateProfile');
            },
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            leading: Image.asset('assets/icons/network.png', color: mainColor),
            title: const Text(LocaleKeys.language).tr(),
            onTap: () {
              Navigator.pushNamed(context, '/chooseLang');
            },
          ),
          const Divider(
            height: 2,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.lock,
              color: mainColor,
            ),
            title: const Text(LocaleKeys.confidentiality).tr(),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            height: 2,
          ),
        ],
      ),
    );
  }
}
