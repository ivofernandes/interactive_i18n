import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/ui/buttons/round_button_ui.dart';

class MyBackButton extends StatelessWidget {
  final GestureTapCallback? onBack;

  const MyBackButton({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) => RoundButtonUI(
        child: Container(
          margin: const EdgeInsets.only(left: 9),
          width: 40,
          height: 40,
          child: InkWell(
            onTap: onBack ?? () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      );
}
