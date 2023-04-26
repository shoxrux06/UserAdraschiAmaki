import 'package:afisha_market/core/bloc/auth/authBloc.dart';
import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/generated/locale_keys.g.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({Key? key}) : super(key: key);

  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
          leading: Image.asset('assets/icons/settings.png', color: mainColor),
          title: const Text(LocaleKeys.settings).tr(),
          onTap: () {
            Navigator.pushNamed(context, '/settingsScreen');
          },
        ),
        ListTile(
          leading: Image.asset('assets/icons/call.png', color: mainColor),
          title: const Text(LocaleKeys.contactWithUs).tr(),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Image.asset('assets/icons/card.png', color: mainColor),
          title: const Text(LocaleKeys.payment).tr(),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Image.asset('assets/icons/share.png', color: mainColor),
          title: const Text(LocaleKeys.share).tr(),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Image.asset('assets/icons/exit.png', color: mainColor),
          title: const Text(LocaleKeys.logOut).tr(),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.delete, color: mainColor),
          title: const Text(LocaleKeys.deleteAccount).tr(),
          onTap: () {
            final token = LocalStorage.instance.getToken();
            _delete(context, token);
          },
        ),
      ],
    );
  }

  void _delete(BuildContext context, String token) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to delete your account?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    // context.read<AuthBloc>().add(DeleteAccountEvent(token));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
              ),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
