import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// The standardized loading indicator in the app.
class LoadingIndicator extends StatelessWidget {
  // VARIABLES =================================================================

  /// A double representing the current progress of the loading.
  final double? value;

  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [LoadingIndicator] matching the given parameters.
  const LoadingIndicator({
    super.key,
    this.value,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      color: context.theme.colorScheme.secondary,
      borderRadius: XLayout.brcX,
    );
  }

// METHODS ===================================================================
}
