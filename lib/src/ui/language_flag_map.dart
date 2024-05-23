class LanguageFlagMap {
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
    'pt': ['br'],
    'es': ['mx', 'ar'],
    'en': ['us', 'au'],
    'fr': ['ca', 'ch'],
  };

  /// Returns the flag code for a given language and device language
  static String getFlagCode(String language, String deviceLanguage) {
    if (_proximityMap.containsKey(language)) {
      if (_proximityMap[language]!.contains(deviceLanguage)) {
        return deviceLanguage;
      }
    }

    // Default conversion
    return _map[language] ?? language;
  }
}
