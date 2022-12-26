import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../contact/contact_column.dart";
import "../contact/contact_title.dart";

/// The content of the body in the "Contact" mode.
class MobileContact extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileContact] matching the given parameters.
  const MobileContact({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(XLayout.paddingM),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
