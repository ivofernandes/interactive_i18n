import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:interactive_i18n/src/ui/select_language_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (key == 'assets/locales/en.json') {
      return jsonEncode(<String, String>{'hello': 'Hello'});
    }
    throw FlutterError('Unable to load asset: $key');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    LanguageProvider.instance = null;
  });

  testWidgets(
    'selecting English reports its language code, not the device country',
    (WidgetTester tester) async {
      final LanguageProvider provider = LanguageProvider(
        contextLocale: const Locale('en', 'US'),
        defaultLanguage: 'en',
        availableLanguages: <String>['en'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        assetBundle: _TestAssetBundle(),
        localeFromContext: true,
      );
      provider.deviceLanguage = 'us';
      await provider.initLanguage(const Locale('en', 'US'));
      LanguageProvider.instance = provider;

      String? selectedLanguage;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectLanguageWidget(
              currentLanguage: provider.getLanguage(),
              popNavigatorOnSelect: false,
              onLanguageSelected: (String language) =>
                  selectedLanguage = language,
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('en')), findsOneWidget);
      await tester.tap(find.byKey(const Key('en')));
      await tester.pumpAndSettle();

      expect(selectedLanguage, 'en');
      expect(provider.getLanguage(), 'en');
    },
  );
}
