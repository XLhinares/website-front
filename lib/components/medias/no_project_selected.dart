import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:x_containers/x_containers.dart";

/// A detailed view of a project.
class NoProjectSelected extends StatelessWidget {
  // CONSTRUCTOR ===============================================================

  /// Returns an instance of [MediaFocus] matching the given parameters.
  const NoProjectSelected({
    super.key,
  });

  // BUILD =====================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: XContainer(
            child: Text("no_project_selected_title".tr),
          ),
        ),
        XLayout.verticalS,
        XContainer(
          child: Text("no_project_selected_content".tr),
        ),
      ],
    );
  }

  // METHODS ===================================================================
}
