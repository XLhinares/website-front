import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

import "../../utils/tools.dart";

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
    return XContainer(
      color: context.theme.colorScheme.secondary,
      child: Text(
        title.tr,
        style: context.titleMediumOnSecondary,
      ),
    );
  }

  // METHODS ===================================================================
}
