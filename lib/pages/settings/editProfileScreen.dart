import 'package:afisha_market/pages/settings/components/editList.dart';
import 'package:afisha_market/pages/utils/circleImage.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)?.profileSettings??'',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: const [
           Expanded(child: EditList())
          ],
        ),
      ),
    );
  }
}
