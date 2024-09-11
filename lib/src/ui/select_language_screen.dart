import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/string_localization.dart';
import 'package:interactive_i18n/src/ui/select_language_widget.dart';

/// This widget is responsible for letting user select a language
class SelectLanguageScreen extends StatelessWidget {
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

  const SelectLanguageScreen({
    this.currentLanguage,
    this.onLanguageSelected,
    this.crossAxisSpacing = 20,
    this.mainAxisSpacing = 20,
    this.bigIconSize = 60,
    this.smallIconSize = 40,
    this.textDescription = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String localCurrentLanguage = currentLanguage ?? LanguageProvider.instance!.getCountryDeviceAware();

    // If languages are not loaded yet
    if (LanguageProvider.instance == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: SelectLanguageWidget(
                  onLanguageSelected: onLanguageSelected,
                  currentLanguage: localCurrentLanguage,
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: mainAxisSpacing,
                  bigIconSize: bigIconSize,
                  smallIconSize: smallIconSize,
                  textDescription: textDescription,
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
}
