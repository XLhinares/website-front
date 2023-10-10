import "package:flutter/material.dart";
import "package:x_containers/x_containers.dart";

import "../../components/contact/exports.dart";

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
    return ListView(
      padding: EdgeInsets.all(XLayout.paddingM),
      physics: const BouncingScrollPhysics(),
      children: [
        const ContactTitle(),
        XLayout.verticalM,

        // FORM ----------------------------------------------------------------
        XContainer(
          padding: EdgeInsets.all(XLayout.paddingM),
          child: ContactColumn(),
        ),
      ],
    );
  }

// METHODS ===================================================================
}
