import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";

/// A widget to that fit all its child within a central column if needed.
class FrameFit extends StatelessWidget {
  // VARIABLES =================================================================

  /// An optional widget to display in the background.
  final Widget? background;

  /// An optional widget to display over the main child.
  ///
  /// It should be carefully be positioned.
  /// This can be used for floating buttons.
  final Widget? overlay;

  /// The widget we want to display within the frame.
  final Widget child;

  /// The space that should surround the child.
  final EdgeInsets? padding;

  /// The aspect ratio of the content of the frame.
  final double frameRatio;

  /// How the child should be aligned in the frame.
  final AlignmentGeometry alignment;

// CONSTRUCTOR ===============================================================

  /// Returns an instance of [FrameFit] matching the given parameters.
  const FrameFit({
    super.key,
    required this.child,
    this.background,
    this.overlay,
    this.padding,
    this.frameRatio = frameRatioDesktop,
    this.alignment = Alignment.center,
  });

// BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    final Widget front = Align(
      alignment: alignment,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.height * frameRatio,
          ),
          child: child,
        ),
      ),
    );

    if (background == null && overlay == null) {
      return front;
    } else {
      return Stack(
        children: []
          ..addIf(background != null, Positioned.fill(child: background!))
          ..add(Positioned.fill(child: front))
          ..addIf(overlay != null, overlay ?? const SizedBox()),
      );
    }
  }
}
