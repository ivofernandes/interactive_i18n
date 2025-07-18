import 'package:flutter/material.dart';
import 'package:interactive_i18n/src/ui/buttons/round_button_ui.dart';

class MyBackButton extends StatelessWidget {
  final GestureTapCallback? onBack;
  final double? width;
  final double? height;

  const MyBackButton({
    super.key,
    this.onBack,
    this.width = 40,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) => RoundButtonUI(
        onTap: onBack ?? () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.only(left: 9),
          width: width,
          height: height,
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
}
