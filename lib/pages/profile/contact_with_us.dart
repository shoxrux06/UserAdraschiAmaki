import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWithUs extends StatefulWidget {
  const ContactWithUs({Key? key}) : super(key: key);

  @override
  State<ContactWithUs> createState() => _ContactWithUsState();
}

class _ContactWithUsState extends State<ContactWithUs> {

  _launchInstagram() async {
    const nativeUrl = "https://www.instagram.com/adraschi_amaki/";
    const webUrl = "https://www.instagram.com/adraschi_amaki/";
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Instagram");
    }
  }

  void launchTelegram() async{
    String url = "https://t.me/adraschi";
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }

  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n?.contactWithUs}'),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
                onTap: launchTelegram,
                child: item('assets/icons/telegram.png', '${l10n?.telegram}')),
            InkWell(
                // behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final url = Uri.parse('tel:+998977888884');
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: item('assets/icons/operator.png', '${l10n?.operator}')),
            InkWell(
                onTap: (){
                  _launchInstagram();
                },
                child: item('assets/icons/instagram.png', '${l10n?.instagram}')
            ),
          ],
        ),
      ),
    );
  }

  Widget item(String url, String text){
    return Container(
        padding: EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(url, color: blueColor,width: 24,height: 24,),
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

  // Widget item(String url, String text) {
  //   return Column(
  //     children: [
  //       const Divider(color: Colors.grey,),
  //       Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
  //         child: Row(
  //           children: [
  //             Image.asset(url, color: blueColor,width: 24,height: 24,),
  //             const SizedBox(
  //               width: 12,
  //             ),
  //             const SizedBox(
  //               width: 12,
  //             ),
  //             Text(text),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
