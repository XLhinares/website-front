import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../tabs/mobile/overlay.dart";

/// A button for the [MobileOverlay].
class OverlayButton extends StatelessWidget {
  // VARIABLES =================================================================

  /// The child to display in the button.
  ///
  /// Ususally an icon.
  final Widget child;

  /// The distance between the top of the screen and the button.
  final double? top;

  /// The distance between the bottom of the screen and the button.
  final double? bottom;

  /// The distance between the left of the screen and the button.
  final double? left;

  /// The distance between the right of the screen and the button.
  final double? right;

  /// Whether to show a button allowing to open the drawer
  final void Function()? onTap;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of the [OverlayButton] tab.
  const OverlayButton({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.onTap,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: XInkContainer(
            width: 1.5 * XLayout.paddingL,
            height: 1.5 * XLayout.paddingL,
            borderDecoration: Border.all(
              color: context.theme.colorScheme.primary,
              width: 4,
            ),
            color: context.theme.colorScheme.surface,
            onTap: onTap,
            child: child,
          ),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
