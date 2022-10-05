// Framework dependencies
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../widgets/widgets.dart";

/// The title widget for the contact form.
class ContactTitle extends StatelessWidget {

  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [ContactTitle] matching the given parameters.
  const ContactTitle({super.key,});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
        padding: EdgeInsets.all(XLayout.paddingM),
        title: PresetText.headline("Contact form".tr,),
        subtitle: PresetText.body("Contact form explanation".tr,),
      );
  }

  // METHODS ===================================================================

}
