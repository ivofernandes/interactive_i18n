import 'package:flutter/material.dart';

class RoundButtonUI extends StatelessWidget {
  final Widget? child;

  const RoundButtonUI({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Material(
            elevation: 10,
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
              width: 40,
              height: 40,
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: 40,
              height: 40,
              child: child,
            ),
          )
        ],
      );
}
