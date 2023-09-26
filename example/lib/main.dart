import 'package:flutter/material.dart';
import 'package:interactive_i18n/interactive_i18n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkModeEnabled = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkModeEnabled = !_isDarkModeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        home: MyHomePage(
          toggleDarkMode: _toggleDarkMode,
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleDarkMode;

  const MyHomePage({
    required this.toggleDarkMode,
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _toolbarHeight = 30;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> availableLanguages = [
      'ar',
      'cs',
      'da',
      'de',
      'el',
      'en',
      'es',
      'fi',
      'fil',
      'fr',
      'he',
      'hi',
      'hu',
      'id',
      'it',
      'ja',
      'ko',
      'no',
      'nl',
      'pl',
      'pt',
      'ru',
      'sv',
      'th',
      'tr',
      'uk',
      'vi',
      'zh'
    ];

    return InteractiveLocalization(
      availableLanguages: availableLanguages,
      languageUpdated: languageUpdated,
      localesPath: 'assets/locales/',
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: _toolbarHeight,
          title: Text('Flutter Demo Home Page'.t),
          leading: IconButton(
            icon: Icon(
              Icons.brightness_6,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
            onPressed: widget.toggleDarkMode,
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: InteractiveI18nSelector(
                iconSize: 50,
                onLanguageSelected: (language) {
                  debugPrint('User picked language $language');
                },
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  'The purpose of this app is to show how to use the interactive_i18n package.'
                      .t,
                ),
              ),
              Text(
                'You have pushed the button this many times:'.t,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text('Toolbar height'.t),
              Slider(
                value: _toolbarHeight,
                min: 30,
                max: 100,
                divisions: 7,
                label: _toolbarHeight.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _toolbarHeight = value;
                  });
                },
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

  void languageUpdated() {
    debugPrint('Set state');
    setState(() {});
  }
}
