import 'package:interactive_i18n/src/core/state/language_provider.dart';

extension StringLocalization on String {
  /// Getter that translates words based on the provided json
  String get t {
    LanguageProvider? languageProvider = LanguageProvider.instance;

    if (languageProvider != null) {
      return languageProvider.translate(this);
    }

    return this;
  }
}
