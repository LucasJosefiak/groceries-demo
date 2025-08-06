import 'package:flutter/widgets.dart' hide Icon;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:groceries_app/ui/widgets/primary_button.dart';
import 'package:groceries_app/ui/ui.dart';

@UseCase(
  name: 'interactive',
  type: PrimaryButton,
)
Widget buildPrimaryButtonInteractiveUseCase(BuildContext context) {
  final showLeading = context.knobs.boolean(
    label: 'showLeading',
    initialValue: false,
  );
  
  final fullWidth = context.knobs.boolean(
    label: 'fullWidth',
    initialValue: false,
  );
  
  final hasCustomWidth = context.knobs.boolean(
    label: 'hasCustomWidth',
    initialValue: false,
  );
  
  final width = hasCustomWidth ? context.knobs.double.slider(
    label: 'width',
    initialValue: 200,
    min: 100,
    max: 400,
  ) : null;
  
  return PrimaryButton(
    content: context.knobs.string(
      label: 'content',
      initialValue: 'Text',
    ),
    enabled: context.knobs.boolean(
      label: 'enabled',
      initialValue: true,
    ),
    fullWidth: fullWidth,
    width: width,
    leading: showLeading ? Icon(
      FontAwesomeIcons.circleExclamation,
      color: AppTheme.of(context).text.inverse,
    ) : null,
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'default',
  type: PrimaryButton,
)
Widget buildPrimaryButtonDefaultUseCase(BuildContext context) {
  return PrimaryButton(
    content: 'Text',
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'disabled',
  type: PrimaryButton,
)
Widget buildPrimaryButtonDisabledUseCase(BuildContext context) {
  return PrimaryButton(
    content: 'Text',
    enabled: false,
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'with leading icon',
  type: PrimaryButton,
)
Widget buildPrimaryButtonWithLeadingIconUseCase(BuildContext context) {
  return PrimaryButton(
    content: 'Verify Email',
    leading: Icon(
      FontAwesomeIcons.circleExclamation,
      color: AppTheme.of(context).text.inverse,
    ),
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'full width',
  type: PrimaryButton,
)
Widget buildPrimaryButtonFullWidthUseCase(BuildContext context) {
  return PrimaryButton(
    content: 'Full Width Button',
    fullWidth: true,
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'fixed width',
  type: PrimaryButton,
)
Widget buildPrimaryButtonFixedWidthUseCase(BuildContext context) {
  return PrimaryButton(
    content: 'Fixed Width',
    width: 200,
    onPressed: () => print('Primary button pressed'),
  );
}

@UseCase(
  name: 'responsive comparison',
  type: PrimaryButton,
)
Widget buildPrimaryButtonResponsiveComparisonUseCase(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Default (content width):'),
      const SizedBox(height: 8),
      PrimaryButton(
        content: 'Default Button',
        onPressed: () => print('Default pressed'),
      ),
      const SizedBox(height: 16),
      const Text('Fixed width (200px):'),
      const SizedBox(height: 8),
      PrimaryButton(
        content: 'Fixed Width',
        width: 200,
        onPressed: () => print('Fixed width pressed'),
      ),
      const SizedBox(height: 16),
      const Text('Full width:'),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: PrimaryButton(
          content: 'Full Width Button',
          fullWidth: true,
          onPressed: () => print('Full width pressed'),
        ),
      ),
    ],
  );
}