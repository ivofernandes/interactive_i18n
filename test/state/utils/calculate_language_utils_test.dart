import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/core/state/utils/calculate_language_utils.dart';

void main() {
  group('LanguageProvider.calculateLanguage', () {
    test('Preferred language is set and available', () {
      const preferredLanguage = 'fr';
      const useDeviceLocale = false;
      const deviceLanguage = 'en';
      final availableLanguages = ['en', 'fr', 'de'];
      const defaultLanguage = 'en';

      final language = CalculateLanguageUtils.calculateLanguage(
        preferredLanguage,
        useDeviceLocale,
        deviceLanguage,
        availableLanguages,
        defaultLanguage,
      );

      expect(language, preferredLanguage);
    });

    test('Preferred language is not set and useDeviceLocale is true', () {
      const preferredLanguage = null;
      const useDeviceLocale = true;
      const deviceLanguage = 'de';
      final availableLanguages = ['en', 'fr', 'de'];
      const defaultLanguage = 'en';

      final language = CalculateLanguageUtils.calculateLanguage(
        preferredLanguage,
        useDeviceLocale,
        deviceLanguage,
        availableLanguages,
        defaultLanguage,
      );

      expect(language, deviceLanguage);
    });

    test('Preferred language is not set and useDeviceLocale is false', () {
      const preferredLanguage = null;
      const useDeviceLocale = false;
      const deviceLanguage = 'fr';
      final availableLanguages = ['en', 'fr', 'de'];
      const defaultLanguage = 'en';

      final language = CalculateLanguageUtils.calculateLanguage(
        preferredLanguage,
        useDeviceLocale,
        deviceLanguage,
        availableLanguages,
        defaultLanguage,
      );

      expect(language, defaultLanguage);
    });

    test('Device language is not available', () {
      const preferredLanguage = null;
      const useDeviceLocale = true;
      const deviceLanguage = 'it';
      final availableLanguages = ['en', 'fr', 'de'];
      const defaultLanguage = 'en';

      final language = CalculateLanguageUtils.calculateLanguage(
        preferredLanguage,
        useDeviceLocale,
        deviceLanguage,
        availableLanguages,
        defaultLanguage,
      );

      expect(language, defaultLanguage);
    });

    test('Preferred language is not available', () {
      const preferredLanguage = 'it';
      const useDeviceLocale = false;
      const deviceLanguage = 'en';
      final availableLanguages = ['en', 'fr', 'de'];
      const defaultLanguage = 'en';

      final language = CalculateLanguageUtils.calculateLanguage(
        preferredLanguage,
        useDeviceLocale,
        deviceLanguage,
        availableLanguages,
        defaultLanguage,
      );

      expect(language, defaultLanguage);
    });
  });

  test('Preferred language is available', () {
    const preferredLanguage = 'it';
    const useDeviceLocale = false;
    const deviceLanguage = 'en';
    final availableLanguages = ['en', 'fr', 'de', 'it'];
    const defaultLanguage = 'en';

    final language = CalculateLanguageUtils.calculateLanguage(
      preferredLanguage,
      useDeviceLocale,
      deviceLanguage,
      availableLanguages,
      defaultLanguage,
    );

    expect(language, preferredLanguage);
  });

  test('Device on mapped language', () {
    const preferredLanguage = null;
    const useDeviceLocale = true;
    const deviceLanguage = 'br';
    final availableLanguages = ['en', 'fr', 'pt'];
    const defaultLanguage = 'en';

    final language = CalculateLanguageUtils.calculateLanguage(
      preferredLanguage,
      useDeviceLocale,
      deviceLanguage,
      availableLanguages,
      defaultLanguage,
    );

    expect(language, 'pt');
  });

  test('Device on not available language', () {
    const preferredLanguage = null;
    const useDeviceLocale = true;
    const deviceLanguage = 'br';
    final availableLanguages = [
      'en',
      'fr',
    ];
    const defaultLanguage = 'en';

    final language = CalculateLanguageUtils.calculateLanguage(
      preferredLanguage,
      useDeviceLocale,
      deviceLanguage,
      availableLanguages,
      defaultLanguage,
    );

    expect(language, defaultLanguage);
  });

  test('Device language without map needed', () {
    const preferredLanguage = null;
    const useDeviceLocale = true;
    const deviceLanguage = 'pt';
    final availableLanguages = ['en', 'fr', 'pt'];
    const defaultLanguage = 'en';

    final language = CalculateLanguageUtils.calculateLanguage(
      preferredLanguage,
      useDeviceLocale,
      deviceLanguage,
      availableLanguages,
      defaultLanguage,
    );

    expect(language, 'pt');
  });
}
