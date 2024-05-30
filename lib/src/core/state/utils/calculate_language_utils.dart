import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';

abstract class CalculateLanguageUtils {
  static String calculateLanguage(String? preferredLanguage, bool useDeviceLocale, String deviceLanguage,
      List<String> availableLanguages, String defaultLanguage) {
    if (preferredLanguage == null) {
      if (useDeviceLocale) {
        final String convertedDeviceLanguage = LanguageFlagMap.getLanguage(deviceLanguage, availableLanguages);
        if (convertedDeviceLanguage != '') {
          return convertedDeviceLanguage;
        }
      }
      return defaultLanguage;
    } else {
      return preferredLanguage;
    }
  }
}
