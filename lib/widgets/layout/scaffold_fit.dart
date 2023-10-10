import "package:flutter/material.dart";

import "../../components/misc/background.dart";
import "frame_fit.dart";

/// A Scaffold that fits its body within a central column if needed.
class ScaffoldFit extends StatelessWidget {
// VARIABLES =================================================================

  /// An optional widget to display in the background.
  final Widget? background;

  /// An optional widget to display over the main child.
  ///
  /// It should be carefully be positioned.
  /// This can be used for floating buttons.
  final Widget? overlay;

  /// An optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// An optional appbar to display at the top of the scaffold
  final AppBar? appBar;

  /// The widget we want to display within the frame.
  final Widget body;

  /// The space that should surround the child.
  final EdgeInsets? padding;

  /// How the child should be aligned in the frame.
  final AlignmentGeometry alignment;

// CONSTRUCTOR ===============================================================

  /// Returns an instance of [ScaffoldFit] matching the given parameters.
  const ScaffoldFit({
    Key? key,
    this.appBar,
    required this.body,
    this.background,
    this.overlay,
    this.bottomNavigationBar,
    this.padding,
    this.alignment = Alignment.center,
  }) : super(key: key);

// BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FrameFit(
        padding: padding,
        background: background ?? const ScaffoldBackground(),
        overlay: overlay,
        alignment: alignment,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

// METHODS ===================================================================
}
