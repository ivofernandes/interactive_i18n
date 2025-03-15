import 'package:flutter/cupertino.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/state/utils/settings_language_constants.dart';
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

  /// Should the operative system to get the language?
  final bool useDeviceLocale;

  /// If SIM is not available. Should get the locale from the context or from view?
  final bool localeFromContext = false;

  /// Function called when the user updates the language
  final void Function()? languageUpdated;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => LanguageProvider(
          context: context,
          defaultLanguage: defaultLanguage,
          availableLanguages: availableLanguages,
          localesPath: localesPath,
          useDeviceLocale: useDeviceLocale,
          assetBundle: DefaultAssetBundle.of(context),
          localeFromContext: localeFromContext,
        ),
        child: Consumer<LanguageProvider>(
          builder: (context, languageState, _) {
            LanguageProvider.instance = languageState;

            if (LanguageProvider.instance != null) {
              // Hammer to avoid rebuilds
              if (DateTime.now().difference(lastBuild).inSeconds > 2) {
                if (languageUpdated != null) {
                  Future.delayed(Duration.zero, () => languageUpdated!());
                  lastBuild = DateTime.now();
                }
              }
            }

            return child;
          },
        ),
      );
}
