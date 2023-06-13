import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:interactive_i18n/src/ui/select_language_screen.dart';

/// Widget to let the user select a different language
class InteractiveI18nSelector extends StatelessWidget {
  const InteractiveI18nSelector({
    this.onLanguageSelected,
    super.key,
  });

  /// Callback when the user selects a new language
  final ValueChanged<String>? onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    // If languages are not loaded yet
    if (LanguageProvider.instance == null) {
      return const SizedBox.shrink();
    }

    // If languages are loaded
    final String currentLanguage = LanguageProvider.instance!.getLanguage();

    // If there are no language skip it
    if (currentLanguage == '') {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (context) => SelectLanguageScreen(
            onLanguageSelected: onLanguageSelected,
          ),
        ),
      ),
      child: LanguageIcon(
        key: const Key('language selection'),
        language: currentLanguage,
        semanticLabel: 'language selection',
      ),
    );
  }
}
