import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../utils/extensions.dart";

/// A small piece of text to display when no project is selected on the desktop projects page.
class NoProjectSelected extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// The number of time that this widget was displayed.
  static int _count = 0;

  /// Returns an instance of [MediaFocus] matching the given parameters.
  NoProjectSelected({
    super.key,
  }) {
    NoProjectSelected._count++;
  }

  // GETTERS ===================================================================

  String get _message {
    if (NoProjectSelected._count < 2) return "project_no_selected_default";
    if (NoProjectSelected._count < 5) return "project_no_selected_count_low";
    if (NoProjectSelected._count < 10) {
      return "project_no_selected_count_medium";
    }
    if (NoProjectSelected._count < 15) return "project_no_selected_count_high";
    return "project_no_selected_count_extreme";
  }

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Text(
      _message.tr,
      style: context.labelMediumOnSurface.asHint,
    );
  }

  // METHODS ===================================================================
}
