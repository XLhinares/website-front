import "package:flutter/material.dart";

import "desktop/page_projects.dart";
import "mobile/page_projects.dart";

/// The one-page style website that the user navigates on.
class ResponsiveProject extends StatelessWidget {
  // VARIABLES =================================================================

  /// An optional behavior to run after reaching the home tab.
  final void Function(BuildContext)? postInit;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ResponsiveProject] matching the given parameters.
  const ResponsiveProject({
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
          return const DesktopPageProjects();
        }
        // } else if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
        //   return ;
        // }
        return MobilePageProjects();
      },
    );
  }

// METHODS ===================================================================
}
