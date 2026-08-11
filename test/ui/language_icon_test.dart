import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:interactive_i18n/src/ui/language_icon.dart';

void main() {
  testWidgets('uses a smaller label for a language-country code',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LanguageIcon(
          language: 'pt-br',
          deviceLanguage: 'en-us',
          textFontStyle: TextStyle(fontSize: 20),
        ),
      ),
    );

    final Text label = tester.widget<Text>(find.text('PT-BR'));
    expect(label.style?.fontSize, 15);
    final Finder labelBox = find.ancestor(
      of: find.text('PT-BR'),
      matching: find.byType(SizedBox),
    );
    expect(
      tester.widgetList<SizedBox>(labelBox).any((box) => box.width == 38),
      isTrue,
    );
    final Finder labelFittedBox = find.ancestor(
      of: find.text('PT-BR'),
      matching: find.byType(FittedBox),
    );
    expect(
      tester
          .widgetList<FittedBox>(labelFittedBox)
          .any((box) => box.fit == BoxFit.scaleDown),
      isTrue,
    );
    final Finder labelContainer = find.ancestor(
      of: find.text('PT-BR'),
      matching: find.byType(Container),
    );
    expect(
      tester.widgetList<Container>(labelContainer).any(
            (container) =>
                container.margin ==
                const EdgeInsets.only(top: 10, bottom: 10),
          ),
      isTrue,
    );
  });

  testWidgets('keeps the configured label size for a base language',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LanguageIcon(
          language: 'pt',
          deviceLanguage: 'en-us',
          textFontStyle: TextStyle(fontSize: 20),
        ),
      ),
    );

    final Text label = tester.widget<Text>(find.text('PT'));
    expect(label.style?.fontSize, 20);
  });
}
