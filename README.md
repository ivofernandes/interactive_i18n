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
interactive_i18n: ^0.0.3
```

## Usage

```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveLocalization(
      availableLanguages: const ['en', 'pt'],
      languageUpdated: () => setState(() {}),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            InteractiveI18nSelector(
              onLanguageSelected: (language) {
                debugPrint('User picked language $language');
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:'.t,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## Tests
Check this test to validate missing translations
https://github.com/ivofernandes/interactive_i18n/blob/main/example/test/check_translations_test.dart

## Like us on pub.dev
Package url:
https://pub.dev/packages/interactive_i18n/example