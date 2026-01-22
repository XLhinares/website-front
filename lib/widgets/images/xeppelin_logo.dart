import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../globals.dart";

/// The [Xeppelin] logo.
class XeppelinLogo extends StatelessWidget {
  // VARIABLES =================================================================

  /// If specified, the size (width and height) to use for the SVG.
  ///
  /// If unspecified, the SVG will take the size of its parent.
  final double? size;

  /// How to inscribe the picture into the space allocated during layout.
  ///
  /// The default is [BoxFit.contain].
  final BoxFit fit;

  /// The color of the foreground logo.
  ///
  /// Defaults to the grey Xeppelin color.
  final Color color;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [XeppelinLogo] matching the given parameters.
  const XeppelinLogo({
    super.key,
    this.size,
    this.color = xeppelinColor,
    this.fit = BoxFit.contain,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/logo.svg",
      width: size,
      height: size,
      fit: fit,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }

  // METHODS ===================================================================
}
