import 'package:flutter/material.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';

/// Mixin to get the device language
mixin MixinDeviceLanguage {
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
        final String simCountryCode = await getCountryFromSIM();

        // If the SIM card country code is valid, we return it
        if (!{'', '--', 'Unkown'}.contains(simCountryCode) &&
            simCountryCode.length == 2) {
          return simCountryCode.toLowerCase();
        }
      }

      if (useDeviceLocale) {
        // If the sim card is not valid for some reason, we return the operative system language configuration
        String deviceLanguage = myLocale.languageCode;

        if (deviceLanguage.length > 2) {
          deviceLanguage = deviceLanguage.substring(0, 2);
        }

        return deviceLanguage.toLowerCase();
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
