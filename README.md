[![pub package](https://img.shields.io/pub/v/interactive_i18n.svg?label=interactive_i18n&color=blue)](https://pub.dev/packages/interactive_i18n)
[![popularity](https://img.shields.io/pub/popularity/interactive_i18n?logo=dart)](https://pub.dev/packages/interactive_i18n/score)
[![likes](https://img.shields.io/pub/likes/interactive_i18n?logo=dart)](https://pub.dev/packages/interactive_i18n/score)
[![pub points](https://img.shields.io/pub/points/sentry?logo=dart)](https://pub.dev/packages/interactive_i18n/score)

# interactive_i18n
Flutter package to take care of internationalization

## Features
- InteractiveLocalization widget to give context and the localesPath to get the translation jsons
- 'Getter translation by adding a dot t in the end of the string'.t
- InteractiveI18nSelector widget that you just need to add to let the user switch between languages

## Getting started
Add the dependency to your `pubspec.yaml`:

```
interactive_i18n: ^1.0.2
```

## Usage

First to use this package you need to create the jsons files, check this example:

https://github.com/ivofernandes/interactive_i18n/tree/main/example/assets/locales

### InteractiveLocalization

InteractiveLocalization is a widget that applies internationalization settings to its child widget. It necessitates a list of available languages and a function that is triggered whenever the language is updated.

In this example, an InteractiveLocalization widget wraps the Scaffold widget of the MyHomePage widget. It specifies the available languages and provides a languageUpdated callback function. The path to the language files is also declared.

```dart
return InteractiveLocalization(
      availableLanguages: availableLanguages,
      languageUpdated: languageUpdated,
      localesPath: 'assets/locales/',
      child: Scaffold(
        ...
      ),
    );

```

### InteractiveI18nSelector
InteractiveI18nSelector is a widget enabling the user to choose the language. It exhibits an icon, which upon clicking presents a new screen with list of available languages. The onLanguageSelected property is a function that is triggered whenever the user selects a language.

In this example, an InteractiveI18nSelector widget is placed in the AppBar widget of the Scaffold widget.

```dart
InteractiveI18nSelector(
    iconSize: 50,
    onLanguageSelected: (language) {
      debugPrint('User picked language $language');
    },
),
```

### Translation String Extension
The .t string extension is utilized to fetch the translated value of a string. In this example, strings are flagged with the .t extension to enable their translation.

For instance, the application uses 'You have pushed the button this many times:'.t to acquire the translation of the string 'You have pushed the button this many times:'.

```dart
Text(
  'You have pushed the button this many times:'.t,
),
```

## Example
Don't forget to check the complete example of how to use the package.

https://pub.dev/packages/interactive_i18n/example

## Tests
Check this test to validate missing translations
https://github.com/ivofernandes/interactive_i18n/blob/main/example/test/check_translations_test.dart

## Like us on pub.dev
Package url:
https://pub.dev/packages/interactive_i18n/example

## Contributing
Would love to see you contributing to this project, if is not fulfilling all your i18n needs, come and open a new issue.
https://github.com/ivofernandes/interactive_i18n