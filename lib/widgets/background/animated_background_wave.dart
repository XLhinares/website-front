import "package:flutter/material.dart";

import "animated_waves.dart";

/// The main background of the Swallo app.
class AnimatedBackgroundWave extends StatelessWidget {
  // VARIABLES =================================================================

  /// The fraction of the screen taken by the wave in the background.
  final double scale;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AnimatedBackgroundWave] matching the given parameters.
  const AnimatedBackgroundWave({
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
