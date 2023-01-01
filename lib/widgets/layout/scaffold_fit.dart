import "package:flutter/material.dart";

import "frame_fit.dart";

/// A Scaffold that fits its body within a central column if needed.
class ScaffoldFit extends StatelessWidget {
// VARIABLES =================================================================

  /// An optional widget to display in the background.
  final Widget? background;

  /// An optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// An optional appbar to display at the top of the scaffold
  final AppBar? appBar;

  /// The widget we want to display within the frame.
  final Widget body;

  /// The space that should surround the child.
  final EdgeInsets? padding;

// CONSTRUCTOR ===============================================================

  /// Returns an instance of [ScaffoldFit] matching the given parameters.
  const ScaffoldFit({
    Key? key,
    this.appBar,
    required this.body,
    this.background,
    this.bottomNavigationBar,
    this.padding,
  }) : super(key: key);

// BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: FrameFit(
        padding: padding,
        background: background,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

// METHODS ===================================================================

}
