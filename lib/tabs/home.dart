import "package:flutter/material.dart";
import "package:responsive_framework/responsive_framework.dart";

import "home_desktop.dart";
import "home_mobile.dart";

/// The one-page style website that the user navigates on.
class Home extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [Home] matching the given parameters.
  const Home({Key? key}) : super(key: key);

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveWrapper.of(context).isLargerThan(TABLET)) {
          return const HomeDesktop();
        }
        // } else if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
        //   return ;
        // }
        return const HomeMobile();
      },
    );
  }

// METHODS ===================================================================

}
