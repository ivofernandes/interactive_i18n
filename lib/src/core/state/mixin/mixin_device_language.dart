import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

/// Mixin to get the device language
mixin MixinDeviceLanguage {
  /// Device language
  String _deviceLanguage = '';

  /// Returns the device language.
  String getDeviceCurrentLanguage() => _deviceLanguage;

  /// Override the device language
  void setDeviceLanguage(String language) => _deviceLanguage = language;

  /// device sim card country code
  String _simCountryCode = '';

  /// Returns the device sim card country code.
  String getSimCountryCode() => _simCountryCode;

  Future<String> getDeviceLanguage(
    BuildContext context,
    String defaultLanguage,
    bool useSimCard,
    bool useDeviceLocale,
    bool localeFromContext,
  ) async {
    try {
      Locale myLocale = Localizations.localeOf(context);

      if (useSimCard) {
        try {
          // Try do do the async call to get the SIM card country code
          _simCountryCode = await getCountryFromSIM();

          // If the SIM card country code is valid, we return it
          if (!{'', '--', 'Unkown'}.contains(_simCountryCode) &&
              _simCountryCode.length == 2) {
            _simCountryCode = _simCountryCode.toLowerCase();
            _deviceLanguage = _simCountryCode;
            return _simCountryCode;
          }
        } catch (e) {
          debugPrint('Can not get any sim card: $e');
        }
      }

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

  Future<String> getCountryFromSIM() async {
    try {
      return await FlutterSimCountryCode.simCountryCode ?? '';
    } catch (e) {
      debugPrint('Can not get any sim card: $e');
      return '';
    }
  }
}
