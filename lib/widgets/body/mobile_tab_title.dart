import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/extensions.dart";

/// A title card for the tabs as seen on mobile.
class MobileTabTitle extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the tab
  final String title;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileTabTitle] matching the given parameters.
  const MobileTabTitle({
    super.key,
    required this.title,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer.text(
      title.tr,
      textStyle: context.titleMediumOnSecondary,
      color: context.theme.colorScheme.secondary,
    );
  }

  // METHODS ===================================================================
}
