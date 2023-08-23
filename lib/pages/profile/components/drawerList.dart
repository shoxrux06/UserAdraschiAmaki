import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/profile/contact_with_us.dart';
import 'package:afisha_market/pages/profile/share_screen.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: mainColor),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/icons/logo.png'),
            ),
          ),
          ListTile(
            leading: Image.asset('assets/icons/settings.png', color: blueColor),
            title: Text(l10n?.settings ?? ''),
            onTap: () {
              Navigator.pushNamed(context, '/settingsScreen');
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/call.png', color: blueColor),
            title: Text(l10n?.contactWithUs ?? ''),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ContactWithUs()));
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/share.png', color: blueColor),
            title: Text(l10n?.share ?? ''),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShareScreen()));
            },
          ),
          ListTile(
            leading: Image.asset('assets/icons/exit.png', color: blueColor),
            title: Text(l10n?.logOut ?? ''),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _delete(BuildContext context, String token) {
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text('${l10n?.pleaseConfirm}'),
          content: Text('${l10n?.areYouSureDeleteYourAccount}'),
          actions: [
            // The "Yes" button
            TextButton(
              onPressed: () {
                // context.read<AuthBloc>().add(DeleteAccountEvent(token));
                LocalStorage.instance.deleteToken();
                LocalStorage.instance.deleteUserId();
                LocalStorage.instance.deleteUsername();
                LocalStorage.instance.deleteUserPhone();
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

}
