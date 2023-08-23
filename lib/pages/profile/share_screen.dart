import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';
class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          l10n?.share??''
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 12,),
              CustomButtonTwo(l10n?.share??'', onTap: (){
                Share.share('Эй, проверьте это замечательное приложение по адресу: https://play.google.com/store/apps/details?id=com.goodafishamarket.afisha_market');
              },),
              CustomButtonTwo(l10n?.qrCode??'')
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String text, BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:blueColor
      ),
      width: MediaQuery.of(context).size.width,
      height: 64,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}
