import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';

/// Utility class for calculating the language to use.
abstract class CalculateLanguageUtils {
  /// Calculates the language to use based on the preferred language,
  /// device locale, available languages, and default language.
  static String calculateLanguage(
    String? preferredLanguage,
    bool useDeviceLocale,
    String deviceLanguage,
    List<String> availableLanguages,
    String defaultLanguage,
  ) {
    // If the preferred language is not set or not available, we use the device language to calculate the language
    if (preferredLanguage == null ||
        !availableLanguages.contains(preferredLanguage)) {
      // If the package is set to use the device locale, we try to convert the device language to a valid language
      if (useDeviceLocale) {
        // Convert the device language to a valid language
        final String convertedDeviceLanguage =
            LanguageFlagMap.getLanguage(deviceLanguage, availableLanguages);

        // If the converted device language is valid, we return it
        if (convertedDeviceLanguage != '' &&
            availableLanguages.contains(convertedDeviceLanguage)) {
          return convertedDeviceLanguage;
        }
      }

      // If the device language is not valid or the package is not set to use the device locale,
      // return the default language
      return defaultLanguage;
    }

    // If the user chosen language is set and available, we return it
    else {
      return preferredLanguage;
    }
  }
}
