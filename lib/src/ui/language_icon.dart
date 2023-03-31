import 'package:flutter/material.dart';

/// Widget that displays a flag for a given language
class LanguageIcon extends StatelessWidget {
  /// The language to display
  final String language;

  /// The semantic label for the flag
  final String? semanticLabel;

  /// The size of the flag
  final double size;

  const LanguageIcon({
    required this.language,
    this.semanticLabel,
    this.size = 38,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String newLanguage = mapLanguage(language);

    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.125),
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: const Offset(2, 3),
              )
            ],
            shape: BoxShape.rectangle,
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: Image.asset(
                  'icons/flags/png/$newLanguage.png',
                  package: 'country_icons',
                  semanticLabel: semanticLabel,
                ).image),
          ),
        ),
        Text(
          language.toUpperCase(),
        ),
      ],
    );
  }

  String mapLanguage(String language) {
    Map<String, String> map = {
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
