import 'package:flutter/material.dart';

/// A customizable round button widget that can contain a child widget,
/// has a specified width and height, and can handle tap events.
/// Now with a tap animation that shrinks and bounces back.
class RoundButtonUI extends StatefulWidget {
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
  State<RoundButtonUI> createState() => _RoundButtonUIState();
}

class _RoundButtonUIState extends State<RoundButtonUI> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 160),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.92).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: Stack(
            children: [
              Material(
                elevation: Theme.of(context).cardTheme.elevation ?? 5,
                shape: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
                    border: widget.border ??
                        Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                  ),
                  width: widget.width,
                  height: widget.height,
                ),
              ),
              ClipOval(
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: widget.child,
                ),
              )
            ],
          ),
        ),
      );
}
