import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../contact/contact_column.dart";
import "../contact/contact_title.dart";

/// The content of the body in the "Projects" mode.
class DesktopContact extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [DesktopContact] matching the given parameters.
  const DesktopContact({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.all(XLayout.paddingM),
        shrinkWrap: true,
        children: [

          // PRESENTATION --------------------------------------------------------

          const ContactTitle(),
          XLayout.verticalM,

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
