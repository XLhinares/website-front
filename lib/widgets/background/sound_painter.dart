import "dart:math";
import "dart:ui" as ui;

import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../globals.dart";

/// An implementation of [CustomPainter] to paint the sound wave animation.
class SoundPainter extends CustomPainter {
  // VARIABLES =================================================================

  /// Where to put the wave, given as a fraction of the viewport height.
  ///
  /// (The offset is computed from the top, so 0.4 means it'll put at 40% of the viewport height from the top).
  final double verticalOffset;

  /// The amplitude of the wave, given as a fraction of the viewport height.
  final double amplitude;

  /// A scale factor that allows to modulate the size of everything.
  final double scale;

  /// The multiplier definying the speed of the modulate wave (not the carry-ing wave)
  final double modulationFactor = 33;

  /// How far along the animation it is.
  final double progress;

  /// An optional color for the sound wave.
  final Color? color;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [SoundPainter] matching the given parameters.
  SoundPainter({
    required this.progress,
    this.verticalOffset = 0.6,
    this.amplitude = 0.4,
    this.scale = 1,
    this.color,
  });

  // METHODS ===================================================================

  /// Calculates the Y position for a sound wave at a given X position.
  /// Uses harmonics (fundamental + 2nd, 3rd, 4th) for a richer waveform.
  double _getWaveY(double x, Size size, double sinfuzz) {
    final double normalizedX = x / size.width - 0.5;
    final double aspectRatio = size.width / size.height;

    // Slow wave for the shape
    double y = cos(2 * normalizedX * sinfuzz);
    // Fast wave for modulation
    // - modulation factor is the key factor
    // - aspect ratio helps boost the density and speed on very wide screens (but there's a power function so it's not too strong)
    // - (normalizedX * sinfux) decides the number of oscillation within a wavelength
    // - (2 * pi * progress) makes the modulated wave travel through the slow wave
    y *= cos(modulationFactor *
        pow(aspectRatio, .2) *
        (normalizedX * sinfuzz + 2 * pi * progress));

    // Scale and center with pulsing amplitude
    final double centerY = size.height * verticalOffset;
    // A pulse to apply to the amplitude
    final double pulse = .7 + 0.3 * sin(2 * pi * progress);
    final double modulatedAmplitude = size.height *
        (amplitude * .5) *
        pulse *
        (.1 + cos(normalizedX * pi * 1.5) * 1.5);

    return centerY + y * modulatedAmplitude;
  }

  /// Paints the sound wave as a continuous line with harmonics.
  void paintSound(Canvas canvas, Size size, Paint paint, {double sinfuzz = 1}) {
    final Path path = Path();
    const int segments = 1000; // Number of points to sample
    final double step = size.width / segments;

    // Start the path at the first point
    final double y0 = _getWaveY(0, size, sinfuzz);
    path.moveTo(0, y0);

    // Add points for each segment
    for (int i = 1; i <= segments; i++) {
      final double x = i * step;
      final double y = _getWaveY(x, size, sinfuzz);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grad = Paint()
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height * verticalOffset),
        size.width / 2,
        <Color>[
          (color ?? Colors.grey).withAlpha(170),
          (color ?? Colors.grey).withAlpha(40),
        ],
        <double>[0, 1],
      )
      // The stroke width depends on the screen aspect ratio so wider screens have thicker strokes while thinner screens have light strokes.
      // The power function further controls the influence of the aspect ratio
      ..strokeWidth = XLayout.paddingM /
          pow(size.height / size.width, .6) /
          frameRatioDesktop *
          scale
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;

    paintSound(canvas, size, grad, sinfuzz: 4);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
