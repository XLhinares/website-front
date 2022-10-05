import "dart:math";
import "dart:ui" as ui;
import "package:flutter/material.dart";

/// An implementation of [CustomPainter] to paint the wave animation.
class CurvePainter extends CustomPainter {

  // VARIABLES =================================================================

  /// A scale factor that allows to modulate the size of everything.
  final double scale;

  /// How far along the animation it is.
  final double progress;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CurvePainter] matching the given parameters.
  CurvePainter({
    this.scale = 1,
    required this.progress,
  });

  // METHODS ===================================================================

  /// Paints a wave on a canvas.
  void paintWave(Canvas canvas, Size size, Paint color, {
    double sinfuzz = 1,
    double offset = 0,
  }) {

    final Path path = Path();

    final double y1 = sin(sinfuzz + 2 * pi * progress * sinfuzz);
    final double y2 = sin(sinfuzz + 2 * pi * progress * sinfuzz + pi / 2);
    final double y3 = sin(sinfuzz + 2 * pi * progress * sinfuzz + pi);



    final double startPointY = size.height
        * ((1-(scale*(1+offset))) + scale * 0.24 * y1);
    final double controlPointY = size.height
        * ((1-(scale*(1+offset))) + scale * 0.30 * y2);
    final double endPointY = size.height
        * ((1-(scale*(1+offset))) + scale * 0.27 * y3);

    path.moveTo(0, size.height);
    path.lineTo(0, startPointY);
    path.quadraticBezierTo(
      size.width * 0.5,
      controlPointY,
      size.width,
      endPointY,
    );
    path.lineTo(size.width, size.height);



    path.close();
    canvas.drawPath(path, color);
  }

  // PAINT =====================================================================

  @override
  void paint(Canvas canvas, Size size) {

    //todo: Color-changing waves

    final Paint grad1 = Paint()..shader = ui.Gradient.radial(
      /// from bottom right
      Offset(size.width,size.height),
      size.height,
      <Color>[
        Colors.grey.withAlpha(100),
        Colors.grey.withAlpha(100),
      ],
      <double>[
        0,
        1.5
      ],
    );

    final Paint grad2 = Paint()..shader = ui.Gradient.radial(
      Offset(size.width,size.height),
      size.height,
      <Color>[
        Colors.grey.withAlpha(100),
        Colors.grey.withAlpha(100),
      ],
      <double>[
        0.3,
        1.5
      ],
    );


    paintWave(canvas, size, grad1, sinfuzz: 5, offset: 0.1);  // Background Wave
    paintWave(canvas, size, grad2, sinfuzz: 7);  // Foreground Wave
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
