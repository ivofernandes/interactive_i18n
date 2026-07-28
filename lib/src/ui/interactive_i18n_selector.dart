import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:interactive_i18n/src/ui/select_language_screen.dart';
import 'package:provider/provider.dart';

/// Widget to let the user select a different language
class InteractiveI18nSelector extends StatelessWidget {
  const InteractiveI18nSelector({
    this.onLanguageSelected,
    this.iconSize = 38,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    this.bigIconSize = 60,
    this.smallIconSize = 40,
    this.textDescription = true,
    this.flagPadding = const EdgeInsets.only(left: 5, top: 5, right: 5),
    this.borderRadius = 10,
    this.selectedColor = Colors.transparent,
    super.key,
  });

  /// Callback when the user selects a new language
  final ValueChanged<String>? onLanguageSelected;

  /// Size of the icon button
  final double iconSize;

  /// Cross axis spacing in the grid view
  final double crossAxisSpacing;

  /// Main axis spacing in the grid view
  final double mainAxisSpacing;

  /// Big icon size
  final double bigIconSize;

  /// Small icon size
  final double smallIconSize;

  /// Text description below the flag
  final bool textDescription;

  /// Horizontal padding for the flag
  final EdgeInsets flagPadding;

  /// Border radius
  final double borderRadius;

  /// Background color for the selected language
  final Color selectedColor;

  @override
  Widget build(BuildContext context) => Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          // Keep the selected value as a language code. [LanguageIcon] resolves
          // the device-aware flag through [LanguageFlagMap], so using a country
          // code here would make that country code appear as the selected
          // language and could persist it through the selection callback.
          final String currentLanguage = languageProvider.getLanguage();
          final String deviceLanguage =
              languageProvider.getDeviceCurrentLanguage();

          final String fallbackLanguage =
              _getFallbackLanguage(languageProvider, deviceLanguage);
          final bool hasSelectedLanguage = currentLanguage.isNotEmpty;
          final String displayedLanguage =
              hasSelectedLanguage ? currentLanguage : fallbackLanguage;

          if (!hasSelectedLanguage) {
            debugPrint(
              '[interactive_i18n] No language selected yet. Showing fallback selector icon for "$displayedLanguage".',
            );
          }

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<Widget>(
                builder: (context) => SelectLanguageScreen(
                  onLanguageSelected: onLanguageSelected,
                  currentLanguage: displayedLanguage,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  bigIconSize: bigIconSize,
                  smallIconSize: smallIconSize,
                  textDescription: textDescription,
                  borderRadius: borderRadius,
                  selectedColor: selectedColor,
                ),
              ),
            ),
            child: hasSelectedLanguage
                ? LanguageIcon(
                    key: ValueKey<String>(displayedLanguage),
                    language: displayedLanguage,
                    deviceLanguage: deviceLanguage,
                    semanticLabel: 'language selection $displayedLanguage',
                    textDescription: false,
                    size: iconSize,
                    flagPadding: const EdgeInsets.all(5),
                    borderRadius: borderRadius,
                  )
                : _buildUnresolvedLanguageSelector(context),
          );
        },
      );

  Widget _buildUnresolvedLanguageSelector(BuildContext context) => Tooltip(
        message: 'Language is not selected yet. Tap to choose one.',
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Theme.of(context).colorScheme.error),
            color: Theme.of(context).colorScheme.errorContainer.withAlpha(80),
          ),
          child: Padding(
            padding: flagPadding,
            child: Icon(
              Icons.language,
              size: iconSize / 2,
              color: Theme.of(context).colorScheme.onErrorContainer,
              semanticLabel:
                  'language selection unavailable, tap to choose language',
            ),
          ),
        ),
      );

  String _getFallbackLanguage(
    LanguageProvider languageProvider,
    String deviceLanguage,
  ) {
    if (languageProvider.availableLanguages.contains(deviceLanguage)) {
      return deviceLanguage;
    }

    if (languageProvider.availableLanguages.isNotEmpty) {
      return languageProvider.availableLanguages.first;
    }

    return '';
  }
}
