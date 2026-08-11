import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/core/language_map/language_flag_map.dart';

void main() {
  group('LanguageFlagMap language-country support', () {
    test('uses the country part as the flag', () {
      expect(LanguageFlagMap.getFlagCode('pt-br', 'en-us'), 'br');
      expect(LanguageFlagMap.getFlagCode('pt-PT', 'en-us'), 'pt');
    });

    test('returns the configured spelling for an exact normalized match', () {
      expect(
        LanguageFlagMap.getLanguage('pt_BR', ['en', 'pt-pt', 'pt-br']),
        'pt-br',
      );
    });

    test('maps a legacy country-only locale to a regional language', () {
      expect(LanguageFlagMap.getLanguage('br', ['en', 'pt-br']), 'pt-br');
    });

    test('returns the explicit country from a regional language', () {
      expect(
        LanguageFlagMap.getDeviceAwareCountryCode('pt-br', 'pt-pt'),
        'br',
      );
    });
  });
}
