import "package:flutter/material.dart";
import "package:simple_animations/simple_animations.dart";

import "../../utils/extensions.dart";
import "sound_painter.dart";

/// An animated widget that looks like a sound wave.
class AnimatedSound extends StatelessWidget {
  // VARIABLES =================================================================

  /// A scale factor that allows to modulate the size of everything.
  final double scale;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [AnimatedSound] matching the given parameters.
  const AnimatedSound({
    super.key,
    this.scale = 1,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.biggest.height,
          width: constraints.biggest.width,
          child: LoopAnimationBuilder<double>(
            duration: const Duration(seconds: 60),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, progress, child) => CustomPaint(
              painter: SoundPainter(
                scale: scale,
                progress: progress,
                color: context.colors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
