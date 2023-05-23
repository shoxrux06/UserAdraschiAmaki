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
    const nativeUrl = "instagram://user?username=afishamarket.uz";
    const webUrl = "https://www.instagram.com/afishamarket.uz/?igshid=MzNlNGNkZWQ4Mg%3D%3D";
    if (await canLaunch(nativeUrl)) {
      await launch(nativeUrl);
    } else if (await canLaunch(webUrl)) {
      await launch(webUrl);
    } else {
      print("can't open Instagram");
    }
  }

  void launchTelegram() async{
    String url = "https://telegram.me/Dostonjon1221";
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
      ),
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        child: Column(
          children: [
            GestureDetector(
                onTap: launchTelegram,
                child: item('assets/icons/telegram.png', '${l10n?.telegram}')),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final url = Uri.parse('tel:+998943485459');
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: item('assets/icons/operator.png', '${l10n?.operator}')),
            GestureDetector(
                onTap: (){
                  _launchInstagram();
                },
                child: item('assets/icons/instagram.png', '${l10n?.instagram}')
            ),
            const Divider(color: Colors.grey,),
          ],
        ),
      ),
    );
  }

  Widget item(String url, String text) {
    return Column(
      children: [
        const Divider(color: Colors.grey,),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Row(
            children: [
              Image.asset(url, color: mainColor,width: 24,height: 24,),
              const SizedBox(
                width: 12,
              ),
              Container(
                width: 1,
                height: 12,
                color: mainColor,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(text),
            ],
          ),
        ),
      ],
    );
  }
}
