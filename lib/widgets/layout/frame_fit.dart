import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/globals.dart";

/// A widget to that fit all its child within a central column if needed.
class FrameFit extends StatelessWidget {
  // VARIABLES =================================================================

  /// An optional widget to display in the background.
  final Widget? background;

  /// The widget we want to display within the frame.
  final Widget child;

  /// The space that should surround the child.
  final EdgeInsets? padding;

  /// The ratio of the horizontal extent over the vertical.
  final double aspectRatio;

// CONSTRUCTOR ===============================================================

  /// Returns an instance of [FrameFit] matching the given parameters.
  const FrameFit({
    Key? key,
    required this.child,
    this.background,
    this.padding,
    this.aspectRatio = frameRatio,
  }) : super(key: key);

// BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    final Widget front = Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Get.height * aspectRatio,
          ),
          child: child,
        ),
      ),
    );

    if (background == null) {
      return front;
    } else {
      return Stack(
        children: [
          Positioned.fill(child: background!),
          Positioned.fill(child: front),
        ],
      );
    }
  }
}
