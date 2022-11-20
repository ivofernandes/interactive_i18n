import 'package:collection/collection.dart' show IterableExtension;

class SettingsLanguageConstants {
  static const List<String> languages = [
    //'ar',
    'cs',
    'da',
    'en',
    'fr',
    'el',
    //'fa',
    'fi',
    'fil',
    'hi',
    'hu',
    'it',
    'ko',
    'km',
    'ms',
    'no',
    'pa',
    'pt',
    'sv',
    'th',
    'uk',
    'vi',
    'de',
    'es',
    //'he',
    'id',
    'ja',
    'mr',
    'nl',
    'pl',
    'ro',
    'ru',
    'te',
    'tr',
    'ur',
    'zh',
  ];

  /// List of languages, this list should be append only!!
  /// As the order can be used to generate an language id in database manager
  static const Map<String, String> LANGUAGES = {
    "pt": "Português",
    "en": "English",
    "es": "Español",
    "it": "Italiano",
    "fr": "Français",
    "de": "Deutsch",
    "nl": "Nederlands",
    "tr": "Turkish",
    "sv": "Svenska",
    "no": "Norwish"
  };

  /// Find language init by description
  static String getLanguageForDesc(String languageDescription) {
    return SettingsLanguageConstants.LANGUAGES.keys.firstWhereOrNull(
        (k) => SettingsLanguageConstants.LANGUAGES[k] == languageDescription)!;
  }

  static String? validLanguage(String locale) {
    if (locale.length > 2) {
      locale = locale.substring(0, 2);
    }

    if (SettingsLanguageConstants.LANGUAGES.containsKey(locale)) {
      return locale;
    } else {
      return null;
    }
  }
}
