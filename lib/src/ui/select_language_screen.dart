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
    final LanguageProvider languageProvider = LanguageProvider.instance!;

    final List<String> languages = languageProvider.availableLanguages;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 60,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: languages.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final String language = languages[index];
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
    );
  }

  Future<void> selectLanguage(String language, BuildContext context) async {
    Navigator.pop(context);
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final LanguageProvider languageProvider = LanguageProvider.instance!;
    await languageProvider.updateLanguage(language, sharedPreferences);
    if (onLanguageSelected != null) {
      onLanguageSelected!(language);
    }
  }
}
