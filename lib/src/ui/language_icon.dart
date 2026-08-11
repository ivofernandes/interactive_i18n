import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';

/// Widget that displays a flag for a given language
class LanguageIcon extends StatelessWidget {
  static const double _regionalLanguageFontScale = 0.75;

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

  /// Margin bottom for the text
  final double marginTextBottom;

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
    this.marginTextBottom = 10,
    this.flagPadding = const EdgeInsets.only(left: 5, top: 5, right: 5),
    this.borderRadius = 50,
    this.backgroundColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String newLanguage =
        LanguageFlagMap.getFlagCode(language, deviceLanguage);
    final bool isRegionalLanguage =
        language.contains('-') || language.contains('_');
    final TextStyle baseTextFontStyle =
        textFontStyle ?? DefaultTextStyle.of(context).style;
    final double? baseFontSize = baseTextFontStyle.fontSize;
    final TextStyle? effectiveTextFontStyle = isRegionalLanguage
        ? baseTextFontStyle.copyWith(
            fontSize: baseFontSize == null
                ? null
                : baseFontSize * _regionalLanguageFontScale,
          )
        : textFontStyle;

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
                    margin: EdgeInsets.only(
                      top: marginTextTop,
                      bottom: marginTextBottom,
                    ),
                    // Keep longer regional codes inside the same width as the
                    // flag instead of allowing them to widen the entire card.
                    child: SizedBox(
                      width: size,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          language.toUpperCase(),
                          maxLines: 1,
                          style: effectiveTextFontStyle,
                        ),
                      ),
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
