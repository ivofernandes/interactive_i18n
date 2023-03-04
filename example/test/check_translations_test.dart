import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// List of folders where the test should try to find translation keys
List<String> sourceDirs = [
  'lib',
  // If you have other modules/packages/microfrontends, add them here
];

/// Regex to find translation keys
/// Should find text like: 'key'.t
/// But not like: 'en', 'pt'
/// The regex should be as specific as possible to avoid false positives
RegExp translateRegex = RegExp(r"\'.+\'\.t");

/// After finding a translation key, this prefix will be removed
String prefix = "'";

/// After finding a translation key, this suffix will be removed
String suffix = "'.t";

/// The directory where the translation files are located
String localesDir = 'assets/locales';

/// The language that is used as reference for missing translations
String referenceLocale = 'pt';

void main() async {

  test('Test the translation key regex', () async {
    // Test if finds false positives
    bool shouldNotMatch = translateRegex.hasMatch("'en', 'pt");
    assert(!shouldNotMatch);

    // Test if finds the correct transaltion key
    bool shouldMatch = translateRegex.hasMatch("'key'.t");
    assert(shouldMatch);
  });


  /// Find missing translation keys for the referenceLocale
  /// This test will fail if there are missing keys
  test('Find missing translation keys for the referenceLocale', () async {
    final List<String> translationKeys = await getTranslationKeys(false);
    String filePath = '$localesDir/$referenceLocale.json';

    final List<String> missingKeys =
        await getMissingKeys(filePath, translationKeys);

    if (missingKeys.isNotEmpty) {
      reportMissingKeys(filePath, missingKeys);
      assert(false);
    }
  });

  test('Find unstranslated keys in all files', () async {
    // Get all keys from dart source code
    final List<String> translationKeys = await getTranslationKeys(true);

    // Check if all locales have all the keys
    final Directory source = Directory(localesDir);
    final List<FileSystemEntity> translationFiles =
        source.listSync(recursive: true).toList();

    for (final FileSystemEntity translationFile in translationFiles) {
      if (translationFile.path.endsWith('.json')) {
        // Get missing keys
        final List<String> missingKeys =
            await getMissingKeys(translationFile.path, translationKeys);

        if (missingKeys.isNotEmpty) {
          reportMissingKeys(translationFile.path, missingKeys);
          assert(false);
        }
      }
    }

    assert(true);
  });
}

void reportMissingKeys(String filePath, List<String> missingKeys) {
  debugPrint('On file $filePath add: ');
  for (var key in missingKeys) {
    if (filePath.contains('en.json')) {
      debugPrint('"$key": "$key",');
    } else {
      debugPrint('"$key": "",');
    }
  }

  debugPrint('------------');
}

Future<List<String>> getMissingKeys(String path, List<String> keys) async {
  final List<String> missingKeys = [];
  final String content = await File(path).readAsString();
  final Map<String, dynamic> jsonObject =
      json.decode(content) as Map<String, dynamic>;
  final List<String> jsonKeys = jsonObject.keys.toList();

  for (final String key in keys) {
    if (!jsonKeys.contains(key)) {
      missingKeys.add(key);
    }
    //keys.add(key);
  }

  print('keys founded: $keys');

  return missingKeys;
}


/// Get all translation keys from dart source code
/// If [searchForKeysInOtherFiles] is true, it will also search for keys in other translation files
Future<List<String>> getTranslationKeys(bool searchForKeysInOtherFiles) async {
  final List<String> keys = await getDartTranslationKeys();

  if (searchForKeysInOtherFiles) {
    // Check if all locales have all the keys
    final Directory source = Directory(localesDir);
    final List<FileSystemEntity> entries =
        source.listSync(recursive: true).toList();

    for (final FileSystemEntity entry in entries) {
      if (entry.path.endsWith('.json')) {
        final String content = await File(entry.path).readAsString();
        final Map<String, dynamic> jsonObject =
            json.decode(content) as Map<String, dynamic>;
        final List<String> jsonKeys = jsonObject.keys.toList();

        jsonKeys.forEach((key) {
          if (!keys.contains(key)) {
            keys.add(key);
          }
        });
      }
    }
  }

  return keys;
}

/// Get all translation keys from dart source code
Future<List<String>> getDartTranslationKeys() async {
  final List<String> result = [];

  for (final String sourceDir in sourceDirs) {
    debugPrint('Searching for stuff inside $sourceDir');
    final Directory source = Directory(sourceDir);

    final List<FileSystemEntity> entries =
        source.listSync(recursive: true).toList();

    debugPrint('Will validate ${entries.length} files/folders');

    for (final FileSystemEntity entry in entries) {
      if (entry.path.endsWith('.dart')) {
        final String content = await File(entry.path).readAsString();

        final Iterable<Match> matches = translateRegex.allMatches(content);
        for (final Match m in matches) {
          String match = m[0]!;
          match = match.replaceAll(suffix, '').replaceAll(prefix, '');
          if (!result.contains(match)) {
            result.add(match);
          }
        }
      }
    }
  }

  return result;
}
