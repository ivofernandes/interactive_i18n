import 'package:flutter/cupertino.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/state/settings_language_constants.dart';
import 'package:provider/provider.dart';

class InteractiveLocalization extends StatelessWidget {
  static DateTime lastBuild = DateTime.now();

  const InteractiveLocalization({
    required this.child,
    this.defaultLanguage = 'en',
    this.availableLanguages = SettingsLanguageConstants.languages,
    this.localesPath = 'assets/locales/',
    this.useDeviceLocale = true,
    this.languageUpdated,
    super.key,
  });

  /// App to be translated
  final Widget child;

  /// Default language
  final String defaultLanguage;

  /// Available languages map
  final List<String> availableLanguages;

  /// Path where the locales json is
  final String localesPath;

  /// Should the app use the device locale
  final bool useDeviceLocale;

  /// Function called when the user updates the language
  final Function? languageUpdated;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider(
        context: context,
        defaultLanguage: defaultLanguage,
        availableLanguages: availableLanguages,
        localesPath: localesPath,
        useDeviceLocale: useDeviceLocale,
      ),
      child: Consumer<LanguageProvider>(
        builder: (context, languageState, _) {
          if (LanguageProvider.instance != null) {
            // Hammer to avoid rebuilds
            if (DateTime.now().difference(lastBuild).inSeconds > 2) {
              if (languageUpdated != null) {
                Future.delayed(Duration.zero, () => languageUpdated!());
                lastBuild = DateTime.now();
              }
            }
          }

          LanguageProvider.instance = languageState;
          return child;
        },
      ),
    );
  }
}
