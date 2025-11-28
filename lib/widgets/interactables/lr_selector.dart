import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A widget that lets the user select a value through "left/right" interactions.
class LRSelector extends StatelessWidget {
  // VARIABLES =================================================================

  /// The behavior to be executed when clicking of the left button.
  final void Function()? leftBehavior;

  /// The behavior to be executed when clicking of the right button.
  final void Function()? rightBehavior;

  /// The widget to display in the middle of the selector.
  final Widget child;

  /// The horizontal extent of this widget.
  final double? width;

  // CONSTRUCTOR ===============================================================

  /// A widget that lets the user select a value through "left/right" interactions.
  const LRSelector({
    super.key,
    required this.child,
    this.leftBehavior,
    this.rightBehavior,
    this.width,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 10) {
          leftBehavior?.call();
        } else if ((details.primaryVelocity ?? 0) < -10) {
          rightBehavior?.call();
        }
      },
      child: XContainer(
        color: context.theme.colorScheme.surface,
        padding: EdgeInsets.symmetric(
          vertical: XLayout.paddingS,
          horizontal: XLayout.paddingXS,
        ),
        width: width,
        child: Row(
          children: [
            GestureDetector(
              onTap: leftBehavior,
              child: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Center(child: child),
            ),
            GestureDetector(
              onTap: rightBehavior,
              child: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  // METHODS ===================================================================
}
