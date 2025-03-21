import 'package:flutter/cupertino.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/state/utils/settings_language_constants.dart';
import 'package:provider/provider.dart';

class InteractiveLocalization extends StatelessWidget {
  // Variables to avoid rebuilds
  static String lastCurrentLanguage = '';

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

  /// Should get the locale from the context or from view?
  final bool localeFromContext = false;

  /// Function called when the user updates the language
  final void Function(String)? languageUpdated;

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
            final currentLanguage = languageState.getLanguage();
            final bool languageChanged = lastCurrentLanguage != currentLanguage;
            final hasListener = languageUpdated != null;

            // Strategy to avoid rebuilds
            if (languageChanged && hasListener) {
              lastCurrentLanguage = currentLanguage;
              Future.delayed(Duration.zero, () => languageUpdated!(currentLanguage));
            }

            return child;
          },
        ),
      );
}
