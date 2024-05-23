import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

/// Mixin to get the device language
mixin MixinDeviceLanguage {
  /// Device language
  String _deviceLanguage = '';

  /// Returns the device language.
  String getDeviceCurrentLanguage() => _deviceLanguage;

  /// device sim card country code
  String _simCountryCode = '';

  /// Returns the device sim card country code.
  String getSimCountryCode() => _simCountryCode;

  Future<String> getDeviceLanguage(
    BuildContext context,
    String defaultLanguage,
    bool useSimCard,
    bool useDeviceLocale,
  ) async {
    try {
      // Check the device operative system language configuration while the context is available
      final Locale myLocale = Localizations.localeOf(context);

      if (useSimCard) {
        // Try do do the async call to get the SIM card country code
        _simCountryCode = await getCountryFromSIM();

        // If the SIM card country code is valid, we return it
        if (!{'', '--', 'Unkown'}.contains(_simCountryCode) && _simCountryCode.length == 2) {
          _simCountryCode = _simCountryCode.toLowerCase();
          _deviceLanguage = _simCountryCode;
          return _simCountryCode;
        }
      }

      if (useDeviceLocale) {
        // If the sim card is not valid for some reason, we return the operative system language configuration
        _deviceLanguage = myLocale.languageCode;

        if (_deviceLanguage.length > 2) {
          _deviceLanguage = _deviceLanguage.substring(0, 2);
        }

        return _deviceLanguage.toLowerCase();
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
