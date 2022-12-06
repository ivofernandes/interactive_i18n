import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  static LanguageProvider? instance;

  static const String languageKey = 'language';

  final String defaultLanguage;
  final List<String> availableLanguages;
  final String localesPath;
  final bool useDeviceLocale;

  String _language = '';
  Map<String, String> _localizedStrings = {};

  String getLanguage() {
    return _language;
  }

  LanguageProvider({
    required BuildContext context,
    required this.defaultLanguage,
    required this.availableLanguages,
    required this.localesPath,
    required this.useDeviceLocale,
  }) {
    initLanguage(context);
  }

  initLanguage(BuildContext context) async {
    String deviceLanguage = getDeviceLanguage(context);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? preferredLanguage = sharedPreferences.getString(languageKey);

    if (preferredLanguage == null) {
      if (useDeviceLocale) {
        _language = deviceLanguage;
      } else {
        _language = defaultLanguage;
      }
    } else {
      _language = preferredLanguage;
    }

    await updateLocations();
  }

  Future<void> updateLocations() async {
    // Load the new json
    String jsonString =
        await rootBundle.loadString('$localesPath$_language.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, '$value');
    });
  }

  Future<void> updateLanguage(String language, SharedPreferences prefs) async {
    bool languageChanged = _language != language;

    // If is the already selected language, just skip
    if (!languageChanged && _localizedStrings.isNotEmpty) {
      return;
    }

    // If is a new language update the provider and the preferences
    _language = language;

    await updateLocations();

    refresh();
  }

  /// Translate a single translation key
  String translate(String key) => _localizedStrings[key] ?? key;

  String getDeviceLanguage(BuildContext context) {
    try {
      Locale myLocale = Localizations.localeOf(context);
      String deviceLanguage = myLocale.languageCode;

      if (deviceLanguage.length > 2) {
        deviceLanguage = deviceLanguage.substring(0, 2);
      }

      return deviceLanguage;
    } catch (error) {
      return defaultLanguage;
    }
  }

  void refresh() {
    notifyListeners();
  }
}
