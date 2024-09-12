import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageWidget extends StatelessWidget {
  /// Callback function to be called when user selects a language
  final ValueChanged<String>? onLanguageSelected;

  /// Current language
  final String? currentLanguage;

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

  /// Should the grid be reversed
  final bool reverse;

  /// Should the grid be shrinked
  final bool shrinkWrap;

  /// Physics of the grid
  final ScrollPhysics? physics;

  /// Margin top for the text
  final double marginTextTop;

  const SelectLanguageWidget({
    this.currentLanguage,
    this.onLanguageSelected,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    this.bigIconSize = 60,
    this.smallIconSize = 40,
    this.textDescription = true,
    this.reverse = true,
    this.shrinkWrap = false,
    this.physics,
    this.marginTextTop = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageProvider? languageProvider = LanguageProvider.instance;

    final String localCurrentLanguage =
        currentLanguage ?? LanguageProvider.instance!.getCountryDeviceAware();

    // If languages are not loaded yet
    if (languageProvider == null) {
      return const SizedBox.shrink();
    }

    // Fetch all available languages
    final List<String> languages = languageProvider.availableLanguages;

    // Calculate the max cross axis extent and icon size based on screen size
    final double maxCrossAxisExtent = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.width > 600 ? 10 : 5);
    final double iconSize =
        MediaQuery.of(context).size.width > 600 ? bigIconSize : smallIconSize;

    return GridView.builder(
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      physics: physics,
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
        language =
            LanguageFlagMap.getDeviceAwareCountryCode(language, deviceLanguage);
        final bool selectedLanguage = language == localCurrentLanguage;

        return GestureDetector(
          onTap: () => selectLanguage(language, context),
          child: LanguageIcon(
            size: iconSize,
            // icon size based on screen size
            key: Key(language),
            language: language,
            deviceLanguage: languageProvider.getDeviceCurrentLanguage(),
            semanticLabel: language,
            textFontStyle: selectedLanguage
                ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    )
                : null,
            elevation: selectedLanguage ? 10 : 0,
            textDescription: textDescription,
            marginTextTop: marginTextTop,
          ),
        );
      },
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
