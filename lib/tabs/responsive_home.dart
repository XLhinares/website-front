import "package:flutter/material.dart";
import "package:responsive_framework/responsive_framework.dart";

import "tabs.dart";

/// The one-page style website that the user navigates on.
class ResponsiveHome extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ResponsiveHome] matching the given parameters.
  const ResponsiveHome({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
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
