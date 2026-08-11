import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Mixin to get the device language
mixin MixinDeviceLanguage {
  /// Device language
  String _deviceLanguage = '';

  /// Returns the device language.
  String getDeviceCurrentLanguage() => _deviceLanguage;

  /// Override the device language
  set deviceLanguage(String language) => _deviceLanguage = language;

  Future<String> getDeviceLanguage(
    Locale contextLocale,
    String defaultLanguage,
    bool useDeviceLocale,
    bool localeFromContext,
  ) async {
    try {
      Locale myLocale = contextLocale;

      if (useDeviceLocale) {
        if (!localeFromContext) {
          // Check the device operative system language configuration while the context is available
          myLocale = ui.PlatformDispatcher.instance.locale;
        }

        // Keep both parts so regional translations can be distinguished.
        final String languageCode = myLocale.languageCode.toLowerCase();
        final String? countryCode = myLocale.countryCode?.toLowerCase();
        _deviceLanguage = countryCode == null || countryCode.isEmpty
            ? languageCode
            : '$languageCode-$countryCode';

        return _deviceLanguage;
      } else {
        return defaultLanguage;
      }
    } catch (error) {
      return defaultLanguage;
    }
  }
}
