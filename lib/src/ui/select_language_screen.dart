import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/string_localization.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This widget is responsible for letting user select a language
class SelectLanguageScreen extends StatelessWidget {
  /// Callback function to be called when user selects a language
  final ValueChanged<String>? onLanguageSelected;

  /// Current language
  final String currentLanguage;

  /// Cross axis spacing in the grid view
  final double crossAxisSpacing;

  /// Main axis spacing in the grid view
  final double mainAxisSpacing;

  /// Big icon size
  final double bigIconSize;

  /// Small icon size
  final double smallIconSize;

  /// Show the text below the flag
  final bool textDescription;

  const SelectLanguageScreen({
    required this.onLanguageSelected,
    required this.currentLanguage,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.bigIconSize,
    required this.smallIconSize,
    this.textDescription = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = LanguageProvider.instance!;

    // Fetch all available languages
    final List<String> languages = languageProvider.availableLanguages;

    // Calculate the max cross axis extent and icon size based on screen size
    final double maxCrossAxisExtent = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.width > 600 ? 10 : 5);
    final double iconSize =
        MediaQuery.of(context).size.width > 600 ? bigIconSize : smallIconSize;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: GridView.builder(
                  reverse: true,
                  // Use a SliverGridDelegate to produce a grid layout
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        maxCrossAxisExtent, // Max cross axis extent calculated above
                    childAspectRatio: 0.85,
                    crossAxisSpacing: crossAxisSpacing,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: languages.length,
                  // Build the language icons
                  itemBuilder: (BuildContext ctx, index) {
                    String language = languages[index];
                    final String deviceLanguage =
                        languageProvider.getDeviceCurrentLanguage();
                    language = LanguageFlagMap.getDeviceAwareCountryCode(
                        language, deviceLanguage);
                    final bool selectedLanguage = language == currentLanguage;

                    return GestureDetector(
                      onTap: () => selectLanguage(language, context),
                      child: LanguageIcon(
                        size: iconSize,
                        // icon size based on screen size
                        key: Key(language),
                        language: language,
                        deviceLanguage:
                            languageProvider.getDeviceCurrentLanguage(),
                        semanticLabel: language,
                        textFontStyle: selectedLanguage
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                )
                            : null,
                        elevation: selectedLanguage ? 10 : 0,
                        textDescription: textDescription,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // Localized string
                Text(
                  'Select language'.t,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Function to handle language selection
  Future<void> selectLanguage(String language, BuildContext context) async {
    Navigator.pop(context);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final LanguageProvider languageProvider = LanguageProvider.instance!;
    await languageProvider.updateLanguage(language, sharedPreferences);
    if (onLanguageSelected != null) {
      onLanguageSelected!(language);
    }
  }
}
