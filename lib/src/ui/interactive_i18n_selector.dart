import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:interactive_i18n/src/ui/select_language_screen.dart';

class InteractiveI18nSelector extends StatelessWidget {
  final Function? selectedNewLanguage;

  const InteractiveI18nSelector({
    this.selectedNewLanguage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // If languages are not loaded yet
    if (LanguageProvider.instance == null) {
      return const SizedBox.shrink();
    }

    // If languages are loaded
    String currentLanguage = LanguageProvider.instance!.getLanguage();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectLanguageScreen(
            selectedNewLanguage: selectedNewLanguage,
          ),
        ),
      ),
      child: LanguageIcon(
        language: currentLanguage,
      ),
    );
  }
}
