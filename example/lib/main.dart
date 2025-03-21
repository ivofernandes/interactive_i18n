import 'package:flutter/material.dart';
import 'package:interactive_i18n/interactive_i18n.dart';
import 'package:provider/provider.dart';

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
        home: MyHomePage(toggleDarkMode: _toggleDarkMode),
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
  bool _useDeviceLocale = true;
  String _defaultLanguage = 'pt';
  bool textDescription = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleUseDeviceLocale(bool value) {
    setState(() {
      _useDeviceLocale = value;
    });
  }

  void _setDefaultLanguage(String language) {
    setState(() {
      _defaultLanguage = language;
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
      useDeviceLocale: _useDeviceLocale,
      defaultLanguage: _defaultLanguage,
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
                key: UniqueKey(),
                iconSize: 50,
                onLanguageSelected: (language) {
                  debugPrint('User picked language $language');
                },
                textDescription: textDescription,
              ),
            )
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'The purpose of this app is to show how to use the interactive_i18n package.'.t,
                  ),
                ),
                Text('You have pushed the button this many times:'.t),
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
                SwitchListTile(
                  title: Text('Text Description'.t),
                  value: textDescription,
                  onChanged: (bool value) {
                    setState(() {
                      textDescription = value;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text('Use Device Locale'.t),
                  value: _useDeviceLocale,
                  onChanged: _toggleUseDeviceLocale,
                ),
                Row(
                  children: [
                    Text('Default language:'.t),
                    DropdownButton<String>(
                      value: _defaultLanguage,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _setDefaultLanguage(newValue);
                        }
                      },
                      items: availableLanguages
                          .map<DropdownMenuItem<String>>((String language) => DropdownMenuItem<String>(
                                value: language,
                                child: Text(language),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                LanguageProviderWidget(),
                const SizedBox(height: 20),
                SelectLanguageWidget(
                  shrinkWrap: true,
                  reverse: false,
                  physics: const NeverScrollableScrollPhysics(),
                  popNavigatorOnSelect: false,
                  onLanguageSelected: (language) async {
                    debugPrint('new language: $language');
                  },
                ),
              ],
            ),
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

  void languageUpdated(String language) {
    debugPrint('languageUpdated to $language');
    setState(() {});
  }
}

class LanguageProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    final List<String> languages = languageProvider.availableLanguages;
    final String currentLanguage = languageProvider.getLanguage();
    final String currentDeviceLanguage = languageProvider.getDeviceCurrentLanguage();
    final TextEditingController _deviceLanguageController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current language'.t + ': $currentLanguage'),
          Text('Language description'.t + ': ${languageProvider.languageDescription}'),
          const SizedBox(height: 10),
          Text('Current device language'.t + ': $currentDeviceLanguage'),
          // TextField to set the device language
          TextField(
            decoration: const InputDecoration(
              labelText: 'Set device language',
              hintText: 'en',
            ),
            onSubmitted: (String value) {
              languageProvider.setDeviceLanguage(value);
              languageProvider.refresh();
            },
            controller: _deviceLanguageController,
          ),
          MaterialButton(
            onPressed: () {
              languageProvider.setDeviceLanguage(_deviceLanguageController.text);
              languageProvider.refresh();
            },
            child: const Text('Set device language'),
          ),
          const SizedBox(height: 10),
          Text('Available languages: $languages'),
        ],
      ),
    );
  }
}
