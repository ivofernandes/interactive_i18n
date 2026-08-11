import 'package:interactive_i18n/src/core/language_map/supported_flags.dart';

abstract class LanguageFlagMap {
  static const Map<String, String> _map = {
    'en': 'gb-nir',
    'sv': 'se',
    'ar': 'sa',
    'da': 'dk',
    'zh': 'cn',
    'hi': 'in',
    'te': 'in',
    'ur': 'in',
    'be': 'in',
    'ko': 'kr',
    'uk': 'ua',
    'he': 'il',
    'ja': 'jp',
    'vi': 'vn',
    'mr': 'in',
    'ms': 'my',
    'el': 'gr',
    'fa': 'ir',
    'cs': 'cz',
    'fil': 'ph',
    'pa': 'pk',
    'km': 'kh',
  };

  static const Map<String, List<String>> _proximityMap = {
    'pt': [
      'br', // Brazil
      'pt', // Portugal
      'ao', // Angola
      'mz', // Mozambique
      'gw', // Guinea-Bissau
      'cv', // Cape Verde
      'st', // São Tomé and Príncipe
      'tl', // Timor-Leste
    ],
    'es': [
      'ar', // Argentina
      'bo', // Bolivia
      'cl', // Chile
      'co', // Colombia
      'cr', // Costa Rica
      'cu', // Cuba
      'do', // Dominican Republic
      'ec', // Ecuador
      'es', // Spain
      'gt', // Guatemala
      'hn', // Honduras
      'mx', // Mexico
      'ni', // Nicaragua
      'pa', // Panama
      'pe', // Peru
      'py', // Paraguay
      'sv', // El Salvador
      'uy', // Uruguay
      've', // Venezuela
    ],
    'en': [
      'us', // United States
      'au', // Australia
      'ca', // Canada
      'nz', // New Zealand
      'ie', // Ireland
      'za', // South Africa
      'jm', // Jamaica
      'tt', // Trinidad and Tobago
      'bs', // Bahamas
      'bb', // Barbados
      'bz', // Belize
      'gh', // Ghana
      'ng', // Nigeria
      'ke', // Kenya
      'zw', // Zimbabwe
      'ug', // Uganda
      'pk', // Pakistan
      'ph', // Philippines
    ],
    'fr': [
      'fr', // France
      'be', // Belgium
      'bf', // Burkina Faso
      'bi', // Burundi
      'bj', // Benin
      'ca', // Canada
      'cd', // Democratic Republic of the Congo
      'cf', // Central African Republic
      'cg', // Republic of the Congo
      'ch', // Switzerland
      'ci', // Ivory Coast
      'cm', // Cameroon
      'dj', // Djibouti
      'ga', // Gabon
      'gn', // Guinea
      'lu', // Luxembourg
      'mg', // Madagascar
      'ml', // Mali
      'mc', // Monaco
      'ne', // Niger
      'rw', // Rwanda
      'sn', // Senegal
      'td', // Chad
      'tg', // Togo
    ],
  };

  /// Returns the flag code for a given language and device language
  static String getFlagCode(String language, String deviceLanguage) {
    final List<String> languageParts = _parts(language);
    final List<String> deviceParts = _parts(deviceLanguage);
    final String baseLanguage = languageParts.first;
    final String? languageCountry =
        languageParts.length > 1 ? languageParts.last : null;
    final String deviceCountry =
        deviceParts.length > 1 ? deviceParts.last : deviceParts.first;

    if (languageCountry != null &&
        SupportedFlags.availableFlags.contains(languageCountry)) {
      return languageCountry;
    }

    String flagLanguage = baseLanguage;
    if (_proximityMap.containsKey(baseLanguage)) {
      final bool isDeviceLanguageSupported =
          _proximityMap[baseLanguage]!.contains(deviceCountry);
      final bool deviceLanguageHasFlag =
          SupportedFlags.availableFlags.contains(deviceCountry);

      if (isDeviceLanguageSupported && deviceLanguageHasFlag) {
        flagLanguage = deviceCountry;
      }
    }

    // Default conversion
    return _map[flagLanguage] ?? flagLanguage;
  }

  /// Returns the language code for a given device language, depending on if the language is available
  static String getLanguage(
      String deviceLanguage, List<String> availableLanguages) {
    final String normalizedDeviceLanguage = _normalize(deviceLanguage);
    for (final String availableLanguage in availableLanguages) {
      if (_normalize(availableLanguage) == normalizedDeviceLanguage) {
        return availableLanguage;
      }
    }

    final List<String> deviceParts = _parts(deviceLanguage);
    final String deviceBase = deviceParts.first;
    final String deviceCountry =
        deviceParts.length > 1 ? deviceParts.last : deviceBase;

    for (final String availableLanguage in availableLanguages) {
      if (_normalize(availableLanguage) == deviceBase) return availableLanguage;
    }

    for (final String language in _proximityMap.keys) {
      if (_proximityMap[language]!.contains(deviceCountry)) {
        for (final String availableLanguage in availableLanguages) {
          final List<String> availableParts = _parts(availableLanguage);
          if (availableParts.first == language &&
              availableParts.length > 1 &&
              availableParts.last == deviceCountry) {
            return availableLanguage;
          }
        }
        for (final String availableLanguage in availableLanguages) {
          if (_normalize(availableLanguage) == language) {
            return availableLanguage;
          }
        }
      }
    }

    return '';
  }

  /// Get device aware country code
  static String getDeviceAwareCountryCode(
      String language, String deviceLanguage) {
    final List<String> languageParts = _parts(language);
    if (languageParts.length > 1) return languageParts.last;

    final List<String> deviceParts = _parts(deviceLanguage);
    final String deviceCountry =
        deviceParts.length > 1 ? deviceParts.last : deviceParts.first;
    if (_proximityMap.containsKey(languageParts.first)) {
      if (_proximityMap[languageParts.first]!.contains(deviceCountry)) {
        return deviceCountry;
      }
    }

    return language;
  }

  static String _normalize(String language) =>
      language.trim().toLowerCase().replaceAll('_', '-');

  static List<String> _parts(String language) =>
      _normalize(language).split('-').where((part) => part.isNotEmpty).toList();
}
