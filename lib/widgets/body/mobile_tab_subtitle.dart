import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A title card for the tabs as seen on mobile.
class MobileTabDescription extends StatelessWidget {
  // VARIABLES =================================================================

  /// The title of the tab
  final String description;

  // CONSTRUCTOR ===============================================================

  /// Returns a [MobileTabDescription] matching the given parameters.
  const MobileTabDescription({
    super.key,
    required this.description,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return XContainer(
      color: context.theme.colorScheme.primary,
      child: Text(
        description.tr,
        style: context.textTheme.bodyMedium,
      ),
    );
  }

  // METHODS ===================================================================
}
