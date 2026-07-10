import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A custom [AssetBundle] for testing purposes.
/// It simulates loading JSON language files from assets.
class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async => ByteData.view(
        Uint8List.fromList(utf8.encode(await loadString(key))).buffer,
      );

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (key == 'assets/locales/en.json') {
      return '{"hello": "Hello", "world": "World"}';
    } else if (key == 'assets/locales/es.json') {
      return '{"hello": "Hola", "world": "Mundo"}';
    }
    throw FlutterError('Unable to load asset: $key');
  }
}

void main() {
  // Ensure the test environment is properly initialized.
  TestWidgetsFlutterBinding.ensureInitialized();

  // Initialize mock values for SharedPreferences before each test.
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('LanguageProvider', () {
    test('initializes with default language when no preference is set',
        () async {
      final LanguageProvider provider = LanguageProvider(
        contextLocale: const Locale('en'),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        assetBundle: TestAssetBundle(),
        localeFromContext: true,
      );

      await provider.initLanguage(const Locale('en'));

      expect(provider.getLanguage(), 'en');
    });

    test('updates language and loads new translations', () async {
      final LanguageProvider provider = LanguageProvider(
        contextLocale: const Locale('en'),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        assetBundle: TestAssetBundle(),
        localeFromContext: true,
      );

      await provider.initLanguage(const Locale('en'));

      expect(provider.getLanguage(), 'en');

      // Retrieve the SharedPreferences instance.
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Update the language to 'es' and verify the change.
      await provider.updateLanguage('es', prefs);

      expect(provider.getLanguage(), 'es');
      expect(provider.translate('hello'), 'Hola');
    });

    test('translates a key correctly', () async {
      final LanguageProvider provider = LanguageProvider(
        contextLocale: const Locale('en'),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        assetBundle: TestAssetBundle(),
        localeFromContext: true,
      );

      await provider.initLanguage(const Locale('en'));

      expect(provider.translate('hello'), 'Hello');
    });

    test('fallback to default language if device language is not available',
        () async {
      final LanguageProvider provider = LanguageProvider(
        contextLocale: const Locale('en'),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: true,
        // Enable device locale usage.
        assetBundle: TestAssetBundle(),
        localeFromContext: true,
      );

      await provider.initLanguage(const Locale('en'));

      // Assuming the device language is not 'en' or 'es', it should fallback to 'en'.
      expect(provider.getLanguage(), 'en');
    });
  });
}
