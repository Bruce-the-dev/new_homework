// localized_strings.dart

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizedStrings {
  final Locale locale;

  LocalizedStrings(this.locale);

  static LocalizedStrings? of(BuildContext context) {
    return Localizations.of<LocalizedStrings>(context, LocalizedStrings);
  }

  static const LocalizationsDelegate<LocalizedStrings> delegate =
      _LocalizedStringsDelegate();

  late Map<String, String> _localizedStrings;

  Future<void> load() async {
    String jsonString =
        await rootBundle.loadString('locale/app_${locale.languageCode}.arb');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String? translate(String key) {
    return _localizedStrings[key];
  }
}

class _LocalizedStringsDelegate
    extends LocalizationsDelegate<LocalizedStrings> {
  const _LocalizedStringsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all supported languages here
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<LocalizedStrings> load(Locale locale) async {
    LocalizedStrings localizations = LocalizedStrings(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizedStringsDelegate old) => false;
}
