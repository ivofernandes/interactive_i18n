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
    String flagLanguage = language;
    if (_proximityMap.containsKey(language)) {
      final bool isDeviceLanguageSupported = _proximityMap[language]!.contains(deviceLanguage);
      final bool deviceLanguageHasFlag = SupportedFlags.availableFlags.contains(deviceLanguage);

      if (isDeviceLanguageSupported && deviceLanguageHasFlag) {
        flagLanguage = deviceLanguage;
      }
    }

    // Default conversion
    return _map[flagLanguage] ?? language;
  }

  static String getLanguage(String deviceLanguage, List<String> availableLanguages) {
    if (availableLanguages.contains(deviceLanguage)) {
      return deviceLanguage;
    }

    final List<String> convertedLanguages = _proximityMap.keys.toList();

    for (final String language in convertedLanguages) {
      if (_proximityMap[language]!.contains(deviceLanguage)) {
        return language;
      }
    }

    return '';
  }
}
