// Flutter dependencies
import "package:flutter/material.dart";

// Project dependencies
import "animated_waves.dart";

/// The main background of the Swallo app.
class AnimatedBackground extends StatelessWidget {

  // VARIABLES =================================================================

  /// The fraction of the screen taken by the wave in the background.
  final double scale;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AnimatedBackground] matching the given parameters.
  const AnimatedBackground({
    Key? key,
    this.scale = 1,
  }) : super(key: key);

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
