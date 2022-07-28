// Flutter dependencies
import "package:flutter/material.dart";

// Package dependencies
import "package:x_containers/x_containers.dart";
import "package:flutter_svg/flutter_svg.dart";

/// An icon within a circular [InkContainer].
class CircularButton extends StatelessWidget {

  // VARIABLES =================================================================

  /// The spatial extent of the button.
  final double? size;

  /// An icon to display in the middle of the button.
  final IconData? icon;

  /// The path to a svg to display in the middle of the button.
  final String? svg;

  /// A widget to display in the middle of the button.
  ///
  /// The [icon] or [svg] arguments should be preferred whenever possible.
  final Widget? child;

  /// The behavior when the button is tapped.
  final void Function()? onTap;

  // GETTERS ===================================================================

  /// The image displayed inside the button.
  Widget get image {
    if (icon != null) {
      return Icon(icon,
        size: size == null ? null : size! * 0.8,
      );
    }

    if (svg != null) {
      return SvgPicture.asset(svg!,
        width: size == null ? null : size! * 0.8,
        height: size == null ? null : size! * 0.8,
      );
    }

    if (child != null) {
      return child!;
    }

    throw Exception("No image was given.");
  }

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [CircularButton] matching the given parameters.
  const CircularButton({
    super.key,
    this.icon,
    this.svg,
    this.child,
    this.size,
    this.onTap,
  }) : assert ((icon != null) ^ (svg != null) ^ (child != null),
  "You should specify either 'icon' or 'svg' or 'child'");

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return InkContainer(
      width: size,
      height: size,
      borderRadius: XLayout.brcX,
      onTap: onTap,
      child: FittedBox(child: image),
    );
  }
}
