import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Mixin to get the device language
mixin MixinDeviceLanguage {
  /// Device language
  String _deviceLanguage = '';

  /// Returns the device language.
  String getDeviceCurrentLanguage() => _deviceLanguage;

  /// Override the device language
  void setDeviceLanguage(String language) => _deviceLanguage = language;

  Future<String> getDeviceLanguage(
    BuildContext context,
    String defaultLanguage,
    bool useDeviceLocale,
    bool localeFromContext,
  ) async {
    try {
      Locale myLocale = Localizations.localeOf(context);

      if (useDeviceLocale) {
        if (!localeFromContext) {
          // Check the device operative system language configuration while the context is available
          myLocale = ui.PlatformDispatcher.instance.locale;
        }

        // If the sim card is not valid for some reason, we return the operative system language configuration
        _deviceLanguage = myLocale.countryCode ?? myLocale.languageCode;
        _deviceLanguage = _deviceLanguage.toLowerCase();
        if (_deviceLanguage.length > 2) {
          _deviceLanguage = _deviceLanguage.substring(0, 2);
        }

        return _deviceLanguage;
      } else {
        return defaultLanguage;
      }
    } catch (error) {
      return defaultLanguage;
    }
  }
}
