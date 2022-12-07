import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/core/string_localization.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageScreen extends StatelessWidget {
  final ValueChanged<String>? onLanguageSelected;

  const SelectLanguageScreen({
    required this.onLanguageSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider = LanguageProvider.instance!;

    List<String> languages = languageProvider.availableLanguages;

    return Scaffold(
      appBar: AppBar(
        title: Text('Select language'.t),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 60,
                childAspectRatio: 0.85,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: languages.length,
            itemBuilder: (BuildContext ctx, index) {
              String language = languages[index];
              return GestureDetector(
                onTap: () => selectLanguage(language, context),
                child: LanguageIcon(
                  key: Key(language),
                  language: language,
                  semanticLabel: language,
                ),
              );
            }),
      ),
    );
  }

  selectLanguage(String language, BuildContext context) async {
    Navigator.pop(context);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LanguageProvider languageProvider = LanguageProvider.instance!;
    await languageProvider.updateLanguage(language, sharedPreferences);
    if (onLanguageSelected != null) {
      onLanguageSelected!(language);
    }
  }
}
