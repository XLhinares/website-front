import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/contact/contact_column.dart";
import "../../widgets/contact/contact_title.dart";

/// The content of the body in the "Projects" mode.
class DesktopMainContact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopMainContact] matching the given parameters.
  const DesktopMainContact({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: XLayout.paddingL),
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        shrinkWrap: true,
        children: [
          // PRESENTATION --------------------------------------------------------

          const ContactTitle(),
          XLayout.verticalL,

          // FORM ----------------------------------------------------------------
          XContainer(
            padding: EdgeInsets.all(XLayout.paddingM),
            child: ContactColumn(),
          ),
        ],
      ),
    );
  }

// METHODS ===================================================================
}
