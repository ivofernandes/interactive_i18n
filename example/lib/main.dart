import 'package:flutter/material.dart';
import 'package:interactive_i18n/interactive_i18n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
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
  Widget build(BuildContext context) => InteractiveLocalization(
        availableLanguages: const ['en', 'pt', 'es', 'fr', 'de', 'it', 'zh', 'hi', 'ja'],
        languageUpdated: () => setState(() {}),
        localesPath: 'assets/locales/',
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: _toolbarHeight,
            title: Text('Flutter Demo Home Page'.t),
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
                    'The purpose of this app is to show how to use the interactive_i18n package.'.t,
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
