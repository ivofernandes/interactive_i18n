import 'package:flutter/material.dart';

/// Widget that displays a flag for a given language
class LanguageIcon extends StatelessWidget {
  /// The language to display
  final String language;

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

  const LanguageIcon({
    required this.language,
    this.semanticLabel,
    this.size = 38,
    this.textDescription = true,
    this.textFontStyle,
    this.elevation = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String newLanguage = mapLanguage(language);

    return Material(
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
                )
              ],
              image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: Image.asset(
                    'icons/flags/png/$newLanguage.png',
                    package: 'country_icons',
                    semanticLabel: semanticLabel,
                  ).image),
            ),
          ),
          if (textDescription)
            const SizedBox(
              height: 10,
            ),
          if (textDescription)
            Text(
              language.toUpperCase(),
              style: textFontStyle,
            ),
        ],
      ),
    );
  }

  /// Map the language to the correct flag
  String mapLanguage(String language) {
    final Map<String, String> map = {
      'en': 'gb-nir',
      'sv': 'se',
      'ar': 'sa',
      'da': 'dk',
      'zh': 'cn',
      'hi': 'in',
      'te': 'in',
      'ur': 'in',
      'be': 'in',
      'ko': 'kr',
      'uk': 'ua',
      'he': 'il',
      'ja': 'jp',
      'vi': 'vn',
      'mr': 'in',
      'ms': 'my',
      'el': 'gr',
      'fa': 'ir',
      'cs': 'cz',
      'fil': 'ph',
      'pa': 'pk',
      'km': 'kh'
    };

    if (map.containsKey(language)) {
      return map[language]!;
    }

    return language;
  }
}
