import 'package:afisha_market/pages/utils/const.dart';
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
        title: Text(
          l10n?.share??''
        ),
      ),
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    Share.share('Эй, проверьте это замечательное приложение по адресу: https://play.google.com/store/apps/details?id=com.goodafishamarket.afisha_market');
                  },
                  child: item(l10n?.share??'', context)),
              const SizedBox(height: 12,),
              item(l10n?.qrCode??'', context),
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
        color:mainColor
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
