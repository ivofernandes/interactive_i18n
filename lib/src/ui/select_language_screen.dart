import 'package:flutter/material.dart';
import 'package:interactive_i18n/interactive_i18n.dart';

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

  /// Padding for the flag
  final EdgeInsets flagPadding;

  /// Border radius
  final double borderRadius;

  /// Background color for the selected language
  final Color selectedColor;

  const SelectLanguageScreen({
    this.currentLanguage,
    this.onLanguageSelected,
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

  @override
  Widget build(BuildContext context) {
    final String localCurrentLanguage =
        currentLanguage ?? LanguageProvider.instance!.getCountryDeviceAware();

    // If languages are not loaded yet
    if (LanguageProvider.instance == null) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: SelectLanguageWidget(
                onLanguageSelected: onLanguageSelected,
                currentLanguage: localCurrentLanguage,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                bigIconSize: bigIconSize,
                smallIconSize: smallIconSize,
                textDescription: textDescription,
                flagPadding: flagPadding,
                borderRadius: borderRadius,
                selectedColor: selectedColor,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox.expand(
                  // ✅ This makes Stack take full width & height of its parent
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Centered label
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        elevation: Theme.of(context).cardTheme.elevation ?? 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Select language'.t,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ),
                      ),

                      // Back button on the left
                      Positioned(
                        left: 10,
                        child: const MyBackButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
