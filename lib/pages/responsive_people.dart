import "package:flutter/material.dart";

import "desktop/page_people.dart";
import "mobile/page_people.dart";

/// The one-page style website that the user navigates on.
class PagePeople extends StatelessWidget {
  // VARIABLES =================================================================

  /// An optional behavior to run after reaching the home tab.
  final void Function(BuildContext)? postInit;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [PagePeople] matching the given parameters.
  const PagePeople({
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
          return const DesktopPagePeople();
        }
        // } else if (ResponsiveWrapper.of(context).isLargerThan(MOBILE)) {
        //   return ;
        // }
        return MobilePagePeople();
      },
    );
  }

// METHODS ===================================================================
}
