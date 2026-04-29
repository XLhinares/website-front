import "package:flutter/material.dart";

import "animated_waves.dart";

/// A wrapper that handled scale changes for a background animation widget.
class ScaledBackground extends StatelessWidget {
  // VARIABLES =================================================================

  /// The fraction of the screen taken by the animated part of the background.
  final double scale;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ScaledBackground] matching the given parameters.
  const ScaledBackground({
    super.key,
    this.scale = 1,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
      tween: Tween<double>(begin: scale, end: scale),
      builder: (context, value, child) => AnimatedWave(scale: value),
    );
  }
}
