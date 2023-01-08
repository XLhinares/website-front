import "package:flutter/material.dart";
import "package:responsive_framework/responsive_framework.dart";

import "tabs.dart";

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
        if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
          return const DesktopTabManager();
        }
        // } else if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
        //   return ;
        // }
        return const MobileTabView();
      },
    );
  }

// METHODS ===================================================================

}
