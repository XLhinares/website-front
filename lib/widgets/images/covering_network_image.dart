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

  /// A builder function that is called if an error occurs during image loading.
  ///
  /// If this builder is not provided, any exceptions will be reported to [FlutterError.onError].
  /// If it is provided, the caller should either handle the exception by providing a replacement widget, or rethrow the exception.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// A builder that specifies the widget to display to the user while an image is still loading.
  ///
  /// If this is null, and the image is loaded incrementally (e.g. over a network),
  /// the user will receive no indication of the progress as the bytes of the image are loaded.
  /// For more information on how to interpret the arguments that are passed to this builder,
  /// see the documentation on [ImageLoadingBuilder].
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;

  // CONSTRUCTOR ===============================================================

  /// Returns a [CoveringNetworkImage] matching the given parameters.
  const CoveringNetworkImage(
    this.path, {
    super.key,
    this.clipBehavior = Clip.hardEdge,
    this.borderRadius = BorderRadius.zero,
    this.fit = BoxFit.cover,
    this.errorBuilder,
    this.loadingBuilder,
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
        errorBuilder: errorBuilder,
        loadingBuilder: loadingBuilder,
      ),
    );
  }

// WIDGETS ===================================================================

}
