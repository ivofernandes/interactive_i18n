import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';

/// Widget that displays a flag for a given language
class LanguageIcon extends StatelessWidget {
  /// The language to display
  final String language;

  /// The language of the device
  final String deviceLanguage;

  /// The semantic label for the flag
  final String? semanticLabel;

  /// The size of the flag
  final double size;

  /// Add a text description below the flag
  final bool textDescription;

  /// Font style
  final TextStyle? textFontStyle;

  /// Elevation of the language icon
  final double elevation;

  /// Margin top for the text
  final double marginTextTop;

  const LanguageIcon({
    required this.language,
    required this.deviceLanguage,
    this.semanticLabel,
    this.size = 38,
    this.textDescription = true,
    this.textFontStyle,
    this.elevation = 0,
    this.marginTextTop = 10,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String newLanguage =
        LanguageFlagMap.getFlagCode(language, deviceLanguage);

    return FittedBox(
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.125),
                    blurRadius: 1,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SvgPicture.asset(
                  'icons/flags/svg/$newLanguage.svg', // Update the path to your SVG files
                  package: 'country_icons',
                  width: size,
                  height: size,
                  semanticsLabel: semanticLabel,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            if (textDescription)
              Container(
                margin: EdgeInsets.only(top: marginTextTop),
                child: Text(
                  language.toUpperCase(),
                  style: textFontStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
