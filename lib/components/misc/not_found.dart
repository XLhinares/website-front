import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A go-to widget to display when some content was not found.
class NotFound extends StatelessWidget {
  // VARIABLES =================================================================

  // CONSTRUCTOR ===============================================================

  /// Returns a [NotFound] matching the given parameters.
  const NotFound({super.key});

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Center(
      child: XContainer.text("misc_content_not_found".tr),
    );
  }

  // WIDGETS ===================================================================
}
