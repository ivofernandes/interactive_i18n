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

  /// Padding for the flag
  final EdgeInsets flagPadding;

  /// Border radius
  final double borderRadius;

  /// Background color of the flag container
  final Color backgroundColor;

  const LanguageIcon({
    required this.language,
    required this.deviceLanguage,
    this.semanticLabel,
    this.size = 38,
    this.textDescription = true,
    this.textFontStyle,
    this.elevation = 0,
    this.marginTextTop = 10,
    this.flagPadding = const EdgeInsets.only(left: 5, top: 5, right: 5),
    this.borderRadius = 50,
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String newLanguage =
        LanguageFlagMap.getFlagCode(language, deviceLanguage);

    return FittedBox(
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color:
                  Theme.of(context).textTheme.bodyMedium!.color!.withAlpha(30),
            ),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: flagPadding,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(31),
                        blurRadius: 1,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
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
        ),
      ),
    );
  }
}
