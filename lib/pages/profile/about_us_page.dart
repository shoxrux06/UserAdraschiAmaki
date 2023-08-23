import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    final l10 = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10?.aboutUs ?? ''),
        elevation: 10,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child:  Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: blueColor,),
                SizedBox(width: 8,),
                Text(
                  'Адрас Атлас Ташкент',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Icon(Icons.punch_clock_rounded, color: blueColor),
                SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    'Режим работы 10⁰⁰-19⁰⁰🇺🇿',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Icon(Icons.car_repair_sharp, color: blueColor),
                SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    'Можно найти через яндекс такси или навигатор adraschi_amak',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              children: [
                Icon(Icons.card_giftcard, color: blueColor),
                SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    'Если вы придёте в наш магазин мы сделаем хорошее сидки и подарки',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16,),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
