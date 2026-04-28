import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../globals.dart";
import "splash.dart";

/// A widget that displays its child if the requirement for the app are loaded.
///
/// While it is not the case, the splash screen is displayed.
class IfAppIsReady extends StatelessWidget {
  // VARIABLES =================================================================

  /// The child to display if the app is ready.
  final Widget child;

  // CONSTRUCTOR ===============================================================

  /// Returns a [IfAppIsReady] matching the given parameters.
  const IfAppIsReady({
    super.key,
    required this.child,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Obx(() => appIsReady.value ? child : Splash());
  }

  // WIDGETS ===================================================================
}
