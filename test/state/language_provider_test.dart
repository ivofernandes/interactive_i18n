import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/core/state/language_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_provider_test.mocks.dart';

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    return ByteData.view(
        Uint8List.fromList(utf8.encode(await loadString(key))).buffer);
  }

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

@GenerateMocks([SharedPreferences, AssetBundle],
    customMocks: [MockSpec<BuildContext>(as: #MockLanguageBuildContext)])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockSharedPreferences mockSharedPreferences;
  late TestAssetBundle testAssetBundle;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    testAssetBundle = TestAssetBundle();
  });

  group('LanguageProvider', () {
    test('initializes with default language when no preference is set',
        () async {
      when(mockSharedPreferences.getString(LanguageProvider.languageKey))
          .thenReturn(null);
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      final LanguageProvider provider = LanguageProvider(
        context: MockLanguageBuildContext(),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        useSimCard: false,
        assetBundle: testAssetBundle,
        localeFromContext: true,
      );

      await provider.initLanguage(MockLanguageBuildContext());

      expect(provider.getLanguage(), 'en');
    });

    test('updates language and loads new translations', () async {
      when(mockSharedPreferences.getString(LanguageProvider.languageKey))
          .thenReturn('en');
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      final LanguageProvider provider = LanguageProvider(
        context: MockLanguageBuildContext(),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        useSimCard: false,
        assetBundle: testAssetBundle,
        localeFromContext: true,
      );

      await provider.initLanguage(MockLanguageBuildContext());

      expect(provider.getLanguage(), 'en');

      await provider.updateLanguage('es', mockSharedPreferences);

      expect(provider.getLanguage(), 'es');
      expect(provider.translate('hello'), 'Hola');
    });

    test('translates a key correctly', () async {
      when(mockSharedPreferences.getString(LanguageProvider.languageKey))
          .thenReturn('en');
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      final LanguageProvider provider = LanguageProvider(
        context: MockLanguageBuildContext(),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: false,
        useSimCard: false,
        assetBundle: testAssetBundle,
        localeFromContext: true,
      );

      await provider.initLanguage(MockLanguageBuildContext());

      expect(provider.translate('hello'), 'Hello');
    });

    test('fallback to default language if device language is not available',
        () async {
      when(mockSharedPreferences.getString(LanguageProvider.languageKey))
          .thenReturn(null);
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      final LanguageProvider provider = LanguageProvider(
        context: MockLanguageBuildContext(),
        defaultLanguage: 'en',
        availableLanguages: ['en', 'es'],
        localesPath: 'assets/locales/',
        useDeviceLocale: true,
        useSimCard: false,
        assetBundle: testAssetBundle,
        localeFromContext: true,
      );

      await provider.initLanguage(MockLanguageBuildContext());

      expect(provider.getLanguage(), 'en');
    });
  });
}
