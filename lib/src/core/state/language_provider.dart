import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: prefer_mixin
class LanguageProvider with ChangeNotifier {
  static LanguageProvider? instance;

  static const String languageKey = 'language';

  final String defaultLanguage;
  final List<String> availableLanguages;
  final String localesPath;
  final bool useDeviceLocale;

  String _language = '';
  Map<String, String> _localizedStrings = {};

  String getLanguage() => _language;

  LanguageProvider({
    required BuildContext context,
    required this.defaultLanguage,
    required this.availableLanguages,
    required this.localesPath,
    required this.useDeviceLocale,
  }) {
    initLanguage(context);
  }

  Future<void> initLanguage(BuildContext context) async {
    // To be best effort, we try to get the device language
    // But if we can't, we just use the default language
    String deviceLanguage = defaultLanguage;
    try {
      deviceLanguage = getDeviceLanguage(context);
    } catch (error) {
      debugPrint(error.toString());
    }

    // Here we try to get the preferred language from the shared preferences
    // If we can't, we just use the device language or the default language
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final String? preferredLanguage =
          sharedPreferences.getString(languageKey);

      if (preferredLanguage == null) {
        if (useDeviceLocale) {
          _language = deviceLanguage;
        } else {
          _language = defaultLanguage;
        }
      } else {
        _language = preferredLanguage;
      }
    } catch (error) {
      _language = deviceLanguage;
    }

    // Update the frontend
    await updateLocations();
  }

  Future<void> updateLocations() async {
    // Load the new json
    final String jsonString =
        await rootBundle.loadString('$localesPath$_language.json');
    final Map<String, dynamic> jsonMap =
        json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, '$value'));
  }

  Future<void> updateLanguage(String language, SharedPreferences prefs) async {
    final bool languageChanged = _language != language;

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
      final Locale myLocale = Localizations.localeOf(context);
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
