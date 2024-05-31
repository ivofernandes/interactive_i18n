import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';
import 'package:interactive_i18n/src/core/state/mixin/mixin_device_language.dart';
import 'package:interactive_i18n/src/core/state/utils/calculate_language_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A Provider for managing and changing the application's language settings.
///
/// This Provider will load language data from JSON files,
/// maintain the current language state, and provide translation functionality.
class LanguageProvider with ChangeNotifier, MixinDeviceLanguage {
  /// Singleton instance of LanguageProvider.
  static LanguageProvider? instance;

  /// Key for the language in Shared Preferences.
  static const String languageKey = 'language';

  /// Default language code.
  final String defaultLanguage;

  /// List of available languages codes.
  final List<String> availableLanguages;

  /// Path to locales files.
  final String localesPath;

  /// Flag to indicate if device locale should be used.
  final bool useDeviceLocale;

  /// Flag to indicate if SIM card should be used for the device language.
  final bool useSimCard;

  /// Current language in use.
  String _language = '';

  /// Map of localized strings loaded from JSON.
  Map<String, String> _localizedStrings = {};

  final AssetBundle assetBundle;

  /// Returns the current language in use.
  String getLanguage() => _language;

  LanguageProvider({
    required BuildContext context,
    required this.defaultLanguage,
    required this.availableLanguages,
    required this.localesPath,
    required this.useDeviceLocale,
    required this.useSimCard,
    required this.assetBundle,
  }) {
    initLanguage(context);
  }

  Future<void> initLanguage(BuildContext context) async {
    // To be best effort, we try to get the device language
    // But if we can't, we just use the default language
    String deviceLanguage = defaultLanguage;

    if (useSimCard || useDeviceLocale) {
      try {
        deviceLanguage = await getDeviceLanguage(context, defaultLanguage, useSimCard, useDeviceLocale);
      } catch (error) {
        debugPrint(error.toString());
      }
    }
    // Here we try to get the preferred language from the shared preferences
    // If we can't, we just use the device language or the default language
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final String? preferredLanguage = sharedPreferences.getString(languageKey);

      _language = CalculateLanguageUtils.calculateLanguage(
          preferredLanguage, useDeviceLocale, deviceLanguage, availableLanguages, defaultLanguage);
    } catch (error) {
      _language = defaultLanguage;
    }

    // Update the frontend
    await updateLocations();
  }

  Future<void> updateLocations() async {
    // Load the new json
    final String jsonString = await assetBundle.loadString('$localesPath$_language.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString) as Map<String, dynamic>;

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, '$value'));
  }

  Future<void> updateLanguage(String languageParam, SharedPreferences prefs) async {
    // Get the language
    final String language = LanguageFlagMap.getLanguage(languageParam, availableLanguages);

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

  void refresh() {
    notifyListeners();
  }

  /// Get the language selected by the user or the device
  /// But if the device language can be mapped to the actual language, return the device language
  String getCountryDeviceAware() {
    final String deviceLanguage = getDeviceCurrentLanguage();

    return LanguageFlagMap.getDeviceAwareCountryCode(_language, deviceLanguage);
  }
}
