import 'package:flutter/material.dart';

class RoundButtonUI extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;

  const RoundButtonUI({
    this.child,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Material(
            elevation: Theme.of(context).cardTheme.elevation ?? 5,
            shape: const CircleBorder(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              width: width ?? 40,
              height: height ?? 40,
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: width ?? 40,
              height: height ?? 40,
              child: child,
            ),
          )
        ],
      );
}
