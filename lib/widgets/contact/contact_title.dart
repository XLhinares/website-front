import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../text/auto_color_text.dart";

/// The title widget for the contact form.
class PeopleTitle extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [PeopleTitle] matching the given parameters.
  const PeopleTitle({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XCard(
      padding: EdgeInsets.all(XLayout.paddingM),
      title: Text(
        "people_title".tr,
        style: context.textTheme.titleMedium,
      ),
      content: AutoColorText(
        "people_description".tr,
        style: context.textTheme.bodyMedium,
      ),
    );
  }

  // METHODS ===================================================================
}
