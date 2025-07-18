import 'package:flutter/material.dart';

/// A customizable round button widget that can contain a child widget,
/// has a specified width and height, and can handle tap events.
class RoundButtonUI extends StatelessWidget {
  /// child is the widget that will be displayed inside the round button.
  final Widget? child;

  /// width is the width of the round button. If not provided, defaults to 40.
  final double? width;

  /// height is the height of the round button. If not provided, defaults to 40.
  final double? height;

  /// onTap is the callback function that will be executed when the button is tapped.
  final GestureTapCallback? onTap;

  /// border is an optional border for the round button. If not provided, a default border will be used.
  final Border? border;

  /// backgroundColor is the background color of the round button. If not provided, defaults to the surface color of the theme.
  final Color? backgroundColor;

  const RoundButtonUI({
    this.child,
    this.width = 40,
    this.height = 40,
    this.onTap,
    this.border,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Material(
              elevation: Theme.of(context).cardTheme.elevation ?? 5,
              shape: const CircleBorder(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor ?? Theme.of(context).colorScheme.surface,
                  border: border ??
                      Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                ),
                width: width,
                height: height,
              ),
            ),
            ClipOval(
              child: SizedBox(
                width: width,
                height: height,
                child: child,
              ),
            )
          ],
        ),
      );
}
