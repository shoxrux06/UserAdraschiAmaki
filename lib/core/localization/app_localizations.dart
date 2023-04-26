import 'dart:convert';

import 'package:afisha_market/core/data/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  late Locale locale;

  AppLocalizations(Locale loc){
    locale = loc;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationDelagate();

  static AppLocalizations? of(context) => Localizations.of<AppLocalizations>(context, AppLocalizations);

  Map<String, String>? _localisedString;

  Future<bool> load() async {
    final jsonString = await rootBundle
        .loadString('assets/languages/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localisedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String? translate(String key) {
    return _localisedString?[key]??'';
  }
}

class _AppLocalizationDelagate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationDelagate();

  @override
  bool isSupported(Locale locale) {
    return Languages.languages
        .map((e) => e.code)
        .toList()
        .contains(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }
}