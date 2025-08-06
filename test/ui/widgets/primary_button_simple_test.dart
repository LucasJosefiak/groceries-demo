import 'package:flutter/material.dart' hide Icon;
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:groceries_app/ui/ui.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PrimaryButton Tests', () {
    testWidgets('basic functionality test', (tester) async {
      bool wasPressed = false;
      
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: AppTheme(
            data: AppThemeData.light,
            child: Material(
              child: PrimaryButton(
                content: 'Test Button',
                onPressed: () => wasPressed = true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      
      await tester.tap(find.byType(PrimaryButton));
      await tester.pump();

      expect(wasPressed, isTrue);
    });

    testGoldens('PrimaryButton responsive states', (tester) async {
      final builder = GoldenBuilder.column(
        wrap: (child) => Directionality(
          textDirection: TextDirection.ltr,
          child: AppTheme(
            data: AppThemeData.light,
            child: Material(child: child),
          ),
        ),
      )
        ..addScenario(
          'Default (content width)',
          PrimaryButton(
            content: 'Default',
            onPressed: () {},
          ),
        )
        ..addScenario(
          'Full Width',
          PrimaryButton(
            content: 'Full Width',
            fullWidth: true,
            onPressed: () {},
          ),
        )
        ..addScenario(
          'Fixed Width 200px',
          PrimaryButton(
            content: 'Fixed Width',
            width: 200,
            onPressed: () {},
          ),
        )
        ..addScenario(
          'Small Width 100px',
          PrimaryButton(
            content: 'Small',
            width: 100,
            onPressed: () {},
          ),
        );

      await tester.pumpWidgetBuilder(builder.build());
      await screenMatchesGolden(tester, 'primary_button_responsive_states');
    });

    testGoldens('PrimaryButton variants', (tester) async {
      final builder = GoldenBuilder.column(
        wrap: (child) => Directionality(
          textDirection: TextDirection.ltr,
          child: AppTheme(
            data: AppThemeData.light,
            child: Material(child: child),
          ),
        ),
      )
        ..addScenario(
          'Enabled',
          PrimaryButton(
            content: 'Enabled',
            onPressed: () {},
          ),
        )
        ..addScenario(
          'Disabled',
          PrimaryButton(
            content: 'Disabled',
            enabled: false,
            onPressed: () {},
          ),
        )
        ..addScenario(
          'With Leading Icon',
          PrimaryButton(
            content: 'Verify',
            leading: Icon(FontAwesomeIcons.circleExclamation),
            onPressed: () {},
          ),
        );

      await tester.pumpWidgetBuilder(builder.build());
      await screenMatchesGolden(tester, 'primary_button_variants');
    });

    testGoldens('PrimaryButton dark theme', (tester) async {
      final builder = GoldenBuilder.column(
        wrap: (child) => Directionality(
          textDirection: TextDirection.ltr,
          child: AppTheme(
            data: AppThemeData.dark,
            child: Material(child: child),
          ),
        ),
      )
        ..addScenario(
          'Dark Theme Default',
          PrimaryButton(
            content: 'Dark Mode',
            onPressed: () {},
          ),
        )
        ..addScenario(
          'Dark Theme Disabled',
          PrimaryButton(
            content: 'Disabled',
            enabled: false,
            onPressed: () {},
          ),
        );

      await tester.pumpWidgetBuilder(builder.build());
      await screenMatchesGolden(tester, 'primary_button_dark_theme');
    });
  });
}