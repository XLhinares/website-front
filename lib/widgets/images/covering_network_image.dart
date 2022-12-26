import "package:flutter/material.dart";

/// A preset image from network.
///
/// It takes covers as much space as it can.
class CoveringNetworkImage extends StatelessWidget {
  // VARIABLES =================================================================

  /// The path to access the resource.
  final String path;

  /// Controls how to clip.
  ///
  /// Must not be set to null or Clip.none.
  final Clip clipBehavior;

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not exceed width/height.
  /// This value is ignored if clipper is non-null.
  final BorderRadius borderRadius;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields.
  /// See the discussion at [paintImage].
  final BoxFit fit;

  // CONSTRUCTOR ===============================================================

  /// Returns a [CoveringNetworkImage] matching the given parameters.
  const CoveringNetworkImage(
    this.path, {
    super.key,
    this.clipBehavior = Clip.hardEdge,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      child: Image.network(
        path,
        fit: fit,
      ),
    );
  }

// WIDGETS ===================================================================

}
