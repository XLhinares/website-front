import "package:flutter/material.dart";

import "desktop/page_home.dart";
import "mobile/page_home.dart";

/// The one-page style website that the user navigates on.
class ResponsiveHome extends StatelessWidget {
  // VARIABLES =================================================================

  /// An optional behavior to run after reaching the home tab.
  final void Function(BuildContext)? postInit;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ResponsiveHome] matching the given parameters.
  const ResponsiveHome({
    super.key,
    this.postInit,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => postInit?.call(context));

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return const DesktopPageHome();
        }
        // } else if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
        //   return ;
        // }
        return const MobilePageHome();
      },
    );
  }

// METHODS ===================================================================
}
